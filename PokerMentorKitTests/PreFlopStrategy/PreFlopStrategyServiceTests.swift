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

	static let allActionsTestCases: Set<[ActionType]> = {
		var allCases = Set<[ActionType]>()

		for raisesCount in 0..<4 {
			for callsCount in 0..<10 {
				for foldsCount in 0..<10 {
					let raises = Array(repeating: ActionType.raise, count: raisesCount)
					let calls = Array(repeating: ActionType.call, count: callsCount)
					let folds = Array(repeating: ActionType.fold, count: foldsCount)

					allCases.insert(raises + calls + folds)
				}
			}
		}

		return allCases.filter { $0.count < 10 }
	}()

	var allFoldActionsTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { !$0.contains(.raise) && !$0.contains(.call) }
	}

	var oneCallActionsTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { !$0.contains(.raise) && $0.contains(.call) }
	}

	var twoOrMoreCallsActionsTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { actions -> Bool in
			!actions.contains(.raise) && actions.filter { $0 == .call }.count > 1
		}
	}

	var oneRaiseAndOtherFoldActionsTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { actions -> Bool in
			!actions.contains(.call) && actions.filter { $0 == .raise }.count == 1
		}
	}

	var oneRaiseAndAtLeastOneCallActionsTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { actions -> Bool in
			actions.contains(.call) && actions.filter { $0 == .raise }.count == 1
		}
	}

	var moreThanOneRaiseActionsTestCases: [[ActionType]] {
		return Self.allActionsTestCases.filter { actions -> Bool in
			actions.filter { $0 == .raise }.count > 1
		}
	}

	// MARK: - All Fold Tests

	func testAllFold(cards: [Card], position: PositionType, expectedAction: ActionType) {
		let testCases: [[ActionType]]

		switch position {
		case .early:
			testCases = allFoldActionsTestCases.filter { $0.count < 3 }
		case .middle:
			testCases = allFoldActionsTestCases.filter { $0.count < 6 }
		case .late:
			testCases = allFoldActionsTestCases.filter { $0.count < 8 }
		case .smallBlind:
			testCases = allFoldActionsTestCases.filter { $0.count < 9 }
		case .bigBlind:
			testCases = allFoldActionsTestCases.filter { $0.count < 10 }
		}

		testCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: position, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - One Call Tests

	func testOneCall(cards: [Card], position: PositionType, expectedAction: ActionType) {
		let testCases: [[ActionType]]

		switch position {
		case .early:
			testCases = oneCallActionsTestCases.filter { $0.count < 3 }
		case .middle:
			testCases = oneCallActionsTestCases.filter { $0.count < 6 }
		case .late:
			testCases = oneCallActionsTestCases.filter { $0.count < 8 }
		case .smallBlind:
			testCases = oneCallActionsTestCases.filter { $0.count < 9 }
		case .bigBlind:
			testCases = oneCallActionsTestCases.filter { $0.count < 10 }
		}

		testCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: position, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - Two Or More Calls

	func testTwoOrMoreCalls(cards: [Card], position: PositionType, expectedAction: ActionType) {
		let testCases: [[ActionType]]

		switch position {
		case .early:
			testCases = twoOrMoreCallsActionsTestCases.filter { $0.count < 3 }
		case .middle:
			testCases = twoOrMoreCallsActionsTestCases.filter { $0.count < 6 }
		case .late:
			testCases = twoOrMoreCallsActionsTestCases.filter { $0.count < 8 }
		case .smallBlind:
			testCases = twoOrMoreCallsActionsTestCases.filter { $0.count < 9 }
		case .bigBlind:
			testCases = twoOrMoreCallsActionsTestCases.filter { $0.count < 10 }
		}

		testCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: position, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - One Raise And Other Fold

	func testOneRaiseAndOtherFold(cards: [Card], position: PositionType, expectedAction: ActionType) {
		let testCases: [[ActionType]]

		switch position {
		case .early:
			testCases = oneRaiseAndOtherFoldActionsTestCases.filter { $0.count < 3 }
		case .middle:
			testCases = oneRaiseAndOtherFoldActionsTestCases.filter { $0.count < 6 }
		case .late:
			testCases = oneRaiseAndOtherFoldActionsTestCases.filter { $0.count < 8 }
		case .smallBlind:
			testCases = oneRaiseAndOtherFoldActionsTestCases.filter { $0.count < 9 }
		case .bigBlind:
			testCases = oneRaiseAndOtherFoldActionsTestCases.filter { $0.count < 10 }
		}

		testCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: position, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - One Raise And At Least One Call

	func testOneRaiseAndAtLeastOneCall(cards: [Card], position: PositionType, expectedAction: ActionType) {
		let testCases: [[ActionType]]

		switch position {
		case .early:
			testCases = oneRaiseAndAtLeastOneCallActionsTestCases.filter { $0.count < 3 }
		case .middle:
			testCases = oneRaiseAndAtLeastOneCallActionsTestCases.filter { $0.count < 6 }
		case .late:
			testCases = oneRaiseAndAtLeastOneCallActionsTestCases.filter { $0.count < 8 }
		case .smallBlind:
			testCases = oneRaiseAndAtLeastOneCallActionsTestCases.filter { $0.count < 9 }
		case .bigBlind:
			testCases = oneRaiseAndAtLeastOneCallActionsTestCases.filter { $0.count < 10 }
		}

		testCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: position, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - More Than One Raise Tests

	func testMoreThanOneRaise(cards: [Card], position: PositionType, expectedAction: ActionType) {
		let testCases: [[ActionType]]

		switch position {
		case .early:
			testCases = moreThanOneRaiseActionsTestCases.filter { $0.count < 3 }
		case .middle:
			testCases = moreThanOneRaiseActionsTestCases.filter { $0.count < 6 }
		case .late:
			testCases = moreThanOneRaiseActionsTestCases.filter { $0.count < 8 }
		case .smallBlind:
			testCases = moreThanOneRaiseActionsTestCases.filter { $0.count < 9 }
		case .bigBlind:
			testCases = moreThanOneRaiseActionsTestCases.filter { $0.count < 10 }
		}

		testCases.forEach {
			let action = sut.actionInFirstRound(cards: cards, position: position, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	// MARK: - After First Round Tests

	func testOneRaise_afterFirstRound(cards: [Card], expectedAction: ActionType) {
		let testCases = Self.allActionsTestCases.filter { actions -> Bool in
			actions.count < 10 && actions.filter { $0 == .raise }.count == 1
		}

		testCases.forEach {
			let action = sut.actionAfterFirstRound(cards: cards, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}

	func testMoreThanOneRaise_afterFirstRound(cards: [Card], expectedAction: ActionType) {
		let testCases = Self.allActionsTestCases.filter { actions -> Bool in
			actions.count < 10 && actions.filter { $0 == .raise }.count > 1
		}

		testCases.forEach {
			let action = sut.actionAfterFirstRound(cards: cards, opponentsActions: $0)
			XCTAssertEqual(action, expectedAction)
		}
	}
}
