//
//  PreFlopStrategyServiceTests.swift
//  PokerMentorKitTests
//
//  Created by Nikita Teplyakov on 05.05.2020.
//

import XCTest
@testable import PokerMentorKit

class PreFlopStrategyServiceTests: XCTestCase {

	let handRecognizer: PreFlopHandRecognizeServiceProtocol = PreFlopHandRecognizeService()
	let testHandsProvider = TestHandsProvider(deckProvider: DeckProvider())
	lazy var sut = PreFlopStrategyService(handRecognizer: handRecognizer)

	static let allActionsTestCases: [[ActionType]] = {
		var allCases = [[ActionType]]()

		for raisesCount in 0..<4 {
			for callsCount in 0..<10 {
				for foldsCount in 0..<10 {
					let raises = Array(repeating: ActionType.raise, count: raisesCount)
					let calls = Array(repeating: ActionType.call, count: callsCount)
					let folds = Array(repeating: ActionType.fold, count: foldsCount)

					allCases.append(raises + calls + folds)
				}
			}
		}

		return allCases.filter { $0.count < 10 }
	}()

	var allFoldActionTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { !$0.contains(.raise) && !$0.contains(.call) }
	}

	var oneCallActionTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { !$0.contains(.raise) && $0.contains(.call) }
	}

	// MARK: - All Fold Tests

	func testAllFold(cards: [Card], position: PositionType, expectedAction: ActionType) {
		let testCases: [[ActionType]]

		switch position {
		case .early:
			testCases = allFoldActionTestCases.filter { $0.count < 3 }
		case .middle:
			testCases = allFoldActionTestCases.filter { $0.count < 6 }
		case .late:
			testCases = allFoldActionTestCases.filter { $0.count < 8 }
		case .smallBlind:
			testCases = allFoldActionTestCases.filter { $0.count < 9 }
		case .bigBlind:
			testCases = allFoldActionTestCases.filter { $0.count < 10 }
		}

		testCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: position, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testAllFold_whenInEarlyPosition(cards: [Card], expectedAction: ActionType) {
		allFoldActionTestCases.filter { $0.count < 3 }
			.forEach {
				let action = sut.actionInFirstRound(cards: cards, position: .early, opponentsActions: $0)
				XCTAssertEqual(action, expectedAction)
		}
	}

	func testAllFold_whenInMiddlePosition(cards: [Card], expectedAction: ActionType) {
		allFoldActionTestCases.filter { $0.count < 6 }
			.forEach {
				let action = sut.actionInFirstRound(cards: cards, position: .middle, opponentsActions: $0)
				XCTAssertEqual(action, expectedAction)
		}
	}

	func testAllFold_whenInLatePosition(cards: [Card], expectedAction: ActionType) {
		allFoldActionTestCases.filter { $0.count < 8 }
			.forEach {
				let action = sut.actionInFirstRound(cards: cards, position: .late, opponentsActions: $0)
				XCTAssertEqual(action, expectedAction)
		}
	}

	func testAllFold_whenInSmallBlindPosition(cards: [Card], expectedAction: ActionType) {
		allFoldActionTestCases.filter { $0.count < 9 }
			.forEach {
				let action = sut.actionInFirstRound(cards: cards, position: .smallBlind, opponentsActions: $0)
				XCTAssertEqual(action, expectedAction)
		}
	}

	func testAllFold_whenInBigBlindPosition(cards: [Card], expectedAction: ActionType) {
		allFoldActionTestCases.filter { $0.count < 10 }
			.forEach {
				let action = sut.actionInFirstRound(cards: cards, position: .bigBlind, opponentsActions: $0)
				XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - One Call Tests

	func testOneCall_whenInEarlyPosition(cards: [Card], expectedAction: ActionType) {
		let allCases: [[ActionType]] = [actions(raisesCount: 0, callsCount: 1, foldsCount: 0),
										actions(raisesCount: 0, callsCount: 1, foldsCount: 1)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .early, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneCall_whenInMiddlePosition(cards: [Card], expectedAction: ActionType) {
		testOneCall_whenInEarlyPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 0, callsCount: 1, foldsCount: 2),
										actions(raisesCount: 0, callsCount: 1, foldsCount: 3),
										actions(raisesCount: 0, callsCount: 1, foldsCount: 4)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .middle, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneCall_whenInLatePosition(cards: [Card], expectedAction: ActionType) {
		testOneCall_whenInMiddlePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 0, callsCount: 1, foldsCount: 5),
										actions(raisesCount: 0, callsCount: 1, foldsCount: 6)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .late, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneCall_whenInSmallBlindPosition(cards: [Card], expectedAction: ActionType) {
		testOneCall_whenInLatePosition(cards: cards, expectedAction: expectedAction)

		let opponentsActions: [ActionType] = actions(raisesCount: 0, callsCount: 1, foldsCount: 7)

		let action = sut.actionInFirstRound(cards: cards, position: .smallBlind, opponentsActions: opponentsActions)
		XCTAssertEqual(action, expectedAction)
	}

	func testOneCall_whenInBigBlindPosition(cards: [Card], expectedAction: ActionType) {
		testOneCall_whenInSmallBlindPosition(cards: cards, expectedAction: expectedAction)

		let opponentsActions: [ActionType] = actions(raisesCount: 0, callsCount: 1, foldsCount: 8)

		let action = sut.actionInFirstRound(cards: cards, position: .bigBlind, opponentsActions: opponentsActions)
		XCTAssertEqual(action, expectedAction)
	}

	// MARK: - Two Or More Calls

	func testTwoOrMoreCalls_whenInEarlyPosition(cards: [Card], expectedAction: ActionType) {
		let opponentsActions: [ActionType] = actions(raisesCount: 0, callsCount: 2, foldsCount: 0)

		let action = sut.actionInFirstRound(cards: cards, position: .early, opponentsActions: opponentsActions)
		XCTAssertEqual(action, expectedAction)
	}

	func testTwoOrMoreCalls_whenInMiddlePosition(cards: [Card], expectedAction: ActionType) {
		testTwoOrMoreCalls_whenInEarlyPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 0, callsCount: 2, foldsCount: 1),
										actions(raisesCount: 0, callsCount: 2, foldsCount: 2),
										actions(raisesCount: 0, callsCount: 2, foldsCount: 3),
										actions(raisesCount: 0, callsCount: 3, foldsCount: 0),
										actions(raisesCount: 0, callsCount: 3, foldsCount: 1),
										actions(raisesCount: 0, callsCount: 3, foldsCount: 2),
										actions(raisesCount: 0, callsCount: 4, foldsCount: 0),
										actions(raisesCount: 0, callsCount: 4, foldsCount: 1),
										actions(raisesCount: 0, callsCount: 5, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .middle, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testTwoOrMoreCalls_whenInLatePosition(cards: [Card], expectedAction: ActionType) {
		testTwoOrMoreCalls_whenInMiddlePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 0, callsCount: 2, foldsCount: 4),
										actions(raisesCount: 0, callsCount: 2, foldsCount: 5),
										actions(raisesCount: 0, callsCount: 3, foldsCount: 3),
										actions(raisesCount: 0, callsCount: 3, foldsCount: 4),
										actions(raisesCount: 0, callsCount: 4, foldsCount: 2),
										actions(raisesCount: 0, callsCount: 4, foldsCount: 3),
										actions(raisesCount: 0, callsCount: 5, foldsCount: 1),
										actions(raisesCount: 0, callsCount: 5, foldsCount: 2),
										actions(raisesCount: 0, callsCount: 6, foldsCount: 0),
										actions(raisesCount: 0, callsCount: 6, foldsCount: 1),
										actions(raisesCount: 0, callsCount: 7, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .late, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testTwoOrMoreCalls_whenInSmallBlindPosition(cards: [Card], expectedAction: ActionType) {
		testTwoOrMoreCalls_whenInLatePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 0, callsCount: 2, foldsCount: 6),
										actions(raisesCount: 0, callsCount: 3, foldsCount: 5),
										actions(raisesCount: 0, callsCount: 4, foldsCount: 4),
										actions(raisesCount: 0, callsCount: 5, foldsCount: 3),
										actions(raisesCount: 0, callsCount: 6, foldsCount: 2),
										actions(raisesCount: 0, callsCount: 7, foldsCount: 1),
										actions(raisesCount: 0, callsCount: 8, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .smallBlind, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testTwoOrMoreCalls_whenInBigBlindPosition(cards: [Card], expectedAction: ActionType) {
		testTwoOrMoreCalls_whenInSmallBlindPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 0, callsCount: 2, foldsCount: 7),
										actions(raisesCount: 0, callsCount: 3, foldsCount: 6),
										actions(raisesCount: 0, callsCount: 4, foldsCount: 5),
										actions(raisesCount: 0, callsCount: 5, foldsCount: 4),
										actions(raisesCount: 0, callsCount: 6, foldsCount: 3),
										actions(raisesCount: 0, callsCount: 7, foldsCount: 2),
										actions(raisesCount: 0, callsCount: 8, foldsCount: 1)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .bigBlind, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - One Raise And Other Fold

	func testOneRaiseAndOtherFold_whenInEarlyPosition(cards: [Card], expectedAction: ActionType) {
		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 0, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 1)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .early, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneRaiseAndOtherFold_whenInMiddlePosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndOtherFold_whenInEarlyPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 0, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 4)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .middle, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneRaiseAndOtherFold_whenInLatePosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndOtherFold_whenInMiddlePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 0, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 6)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .late, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneRaiseAndOtherFold_whenInSmallBlindPosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndOtherFold_whenInLatePosition(cards: cards, expectedAction: expectedAction)

		let opponentsActions: [ActionType] = actions(raisesCount: 1, callsCount: 0, foldsCount: 7)

		let action = sut.actionInFirstRound(cards: cards, position: .smallBlind, opponentsActions: opponentsActions)
		XCTAssertEqual(action, expectedAction)
	}

	func testOneRaiseAndOtherFold_whenInBigBlindPosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndOtherFold_whenInSmallBlindPosition(cards: cards, expectedAction: expectedAction)

		let opponentsActions: [ActionType] = actions(raisesCount: 1, callsCount: 0, foldsCount: 8)

		let action = sut.actionInFirstRound(cards: cards, position: .bigBlind, opponentsActions: opponentsActions)
		XCTAssertEqual(action, expectedAction)
	}

	// MARK: - One Raise And At Least One Call

	func testOneRaiseAndAtLeastOneCall_whenInEarlyPosition(cards: [Card], expectedAction: ActionType) {
		let opponentsActions: [ActionType] = actions(raisesCount: 1, callsCount: 1, foldsCount: 0)

		let action = sut.actionInFirstRound(cards: cards, position: .early, opponentsActions: opponentsActions)
		XCTAssertEqual(action, expectedAction)
	}

	func testOneRaiseAndAtLeastOneCall_whenInMiddlePosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndAtLeastOneCall_whenInEarlyPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 1, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .middle, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneRaiseAndAtLeastOneCall_whenInLatePosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndAtLeastOneCall_whenInMiddlePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 1, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 6, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .late, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneRaiseAndAtLeastOneCall_whenInSmallBlindPosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndAtLeastOneCall_whenInLatePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 1, foldsCount: 6),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 6, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 7, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .smallBlind, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testOneRaiseAndAtLeastOneCall_whenInBigBlindPosition(cards: [Card], expectedAction: ActionType) {
		testOneRaiseAndAtLeastOneCall_whenInSmallBlindPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 1, foldsCount: 7),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 6),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 6, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 7, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 8, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .bigBlind, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - More Than One Raise Tests

	func testMoreThanOneRaise_whenInEarlyPosition(cards: [Card], expectedAction: ActionType) {
		let opponentsActions: [ActionType] = actions(raisesCount: 2, callsCount: 0, foldsCount: 0)

		let action = sut.actionInFirstRound(cards: cards, position: .early, opponentsActions: opponentsActions)
		XCTAssertEqual(action, expectedAction)
	}

	func testMoreThanOneRaise_whenInMiddlePosition(cards: [Card], expectedAction: ActionType) {
		testMoreThanOneRaise_whenInEarlyPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 2, callsCount: 0, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .middle, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testMoreThanOneRaise_whenInLatePosition(cards: [Card], expectedAction: ActionType) {
		testMoreThanOneRaise_whenInMiddlePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 2, callsCount: 0, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 5),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 5, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 4),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 4, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .late, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testMoreThanOneRaise_whenInSmallBlindPosition(cards: [Card], expectedAction: ActionType) {
		testMoreThanOneRaise_whenInLatePosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 2, callsCount: 0, foldsCount: 6),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 5),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 5, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 6, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 5),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 4),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 4, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 5, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .smallBlind, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testMoreThanOneRaise_whenInBigBlindPosition(cards: [Card], expectedAction: ActionType) {
		testMoreThanOneRaise_whenInSmallBlindPosition(cards: cards, expectedAction: expectedAction)

		let allCases: [[ActionType]] = [actions(raisesCount: 2, callsCount: 0, foldsCount: 7),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 6),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 5),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 5, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 6, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 7, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 6),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 5),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 4),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 4, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 5, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 6, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: .bigBlind, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - After First Round Tests

	func testOneRaise_afterFirstRound(cards: [Card], expectedAction: ActionType) {
		let allCases: [[ActionType]] = [actions(raisesCount: 1, callsCount: 0, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 6),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 7),
										actions(raisesCount: 1, callsCount: 0, foldsCount: 8),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 6),
										actions(raisesCount: 1, callsCount: 1, foldsCount: 7),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 2, foldsCount: 6),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 3, foldsCount: 5),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 4, foldsCount: 4),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 5, foldsCount: 3),
										actions(raisesCount: 1, callsCount: 6, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 6, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 6, foldsCount: 2),
										actions(raisesCount: 1, callsCount: 7, foldsCount: 0),
										actions(raisesCount: 1, callsCount: 7, foldsCount: 1),
										actions(raisesCount: 1, callsCount: 8, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionAfterFirstRound(cards: cards, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testMoreThanOneRaise_afterFirstRound(cards: [Card], expectedAction: ActionType) {
		let allCases: [[ActionType]] = [actions(raisesCount: 2, callsCount: 0, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 5),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 6),
										actions(raisesCount: 2, callsCount: 0, foldsCount: 7),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 5),
										actions(raisesCount: 2, callsCount: 1, foldsCount: 6),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 2, foldsCount: 5),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 3, foldsCount: 4),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 4, foldsCount: 3),
										actions(raisesCount: 2, callsCount: 5, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 5, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 5, foldsCount: 2),
										actions(raisesCount: 2, callsCount: 6, foldsCount: 0),
										actions(raisesCount: 2, callsCount: 6, foldsCount: 1),
										actions(raisesCount: 2, callsCount: 7, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 4),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 5),
										actions(raisesCount: 3, callsCount: 0, foldsCount: 6),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 4),
										actions(raisesCount: 3, callsCount: 1, foldsCount: 5),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 2, foldsCount: 4),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 3, foldsCount: 3),
										actions(raisesCount: 3, callsCount: 4, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 4, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 4, foldsCount: 2),
										actions(raisesCount: 3, callsCount: 5, foldsCount: 0),
										actions(raisesCount: 3, callsCount: 5, foldsCount: 1),
										actions(raisesCount: 3, callsCount: 6, foldsCount: 0)]

		allCases.forEach {
			let action = sut.actionAfterFirstRound(cards: cards, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - Help Methods

//	func actions(raisesCount: Int, callsCount: Int, foldsCount: Int) -> [ActionType] {
//		let raises = Array(repeating: ActionType.raise, count: raisesCount)
//		let calls = Array(repeating: ActionType.call, count: callsCount)
//		let folds = Array(repeating: ActionType.fold, count: foldsCount)
//
//		return raises + calls + folds
//	}
}

