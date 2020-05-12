//
//  PreFlopStrategyServiceVeryStrongHandTests.swift
//  PokerMentorKitTests
//
//  Created by Nikita Teplyakov on 05.05.2020.
//

import XCTest
@testable import PokerMentorKit

class PreFlopStrategyServiceVeryStrongHandTests: PreFlopStrategyServiceTests {

	lazy var hands = testHandsProvider.allVeryStrongHands()

	// MARK: - First Round

	func testVeryStrongHandStrategy() {
		let cards = randomHand()

		testAllFold(cards: cards, position: .early, expectedAction: .raise)
		testAllFold(cards: cards, position: .middle, expectedAction: .raise)
		testAllFold(cards: cards, position: .late, expectedAction: .raise)
		testAllFold(cards: cards, position: .smallBlind, expectedAction: .raise)
		testAllFold(cards: cards, position: .bigBlind, expectedAction: .raise)

		testOneCall(cards: cards, position: .early, expectedAction: .raise)
		testOneCall(cards: cards, position: .middle, expectedAction: .raise)
		testOneCall(cards: cards, position: .late, expectedAction: .raise)
		testOneCall(cards: cards, position: .smallBlind, expectedAction: .raise)
		testOneCall(cards: cards, position: .bigBlind, expectedAction: .raise)

		testTwoOrMoreCalls(cards: cards, position: .early, expectedAction: .raise)
		testTwoOrMoreCalls(cards: cards, position: .middle, expectedAction: .raise)
		testTwoOrMoreCalls(cards: cards, position: .late, expectedAction: .raise)
		testTwoOrMoreCalls(cards: cards, position: .smallBlind, expectedAction: .raise)
		testTwoOrMoreCalls(cards: cards, position: .bigBlind, expectedAction: .raise)

		testOneRaiseAndOtherFold(cards: cards, position: .early, expectedAction: .raise)
		testOneRaiseAndOtherFold(cards: cards, position: .middle, expectedAction: .raise)
		testOneRaiseAndOtherFold(cards: cards, position: .late, expectedAction: .raise)
		testOneRaiseAndOtherFold(cards: cards, position: .smallBlind, expectedAction: .raise)
		testOneRaiseAndOtherFold(cards: cards, position: .bigBlind, expectedAction: .raise)

		testOneRaiseAndAtLeastOneCall(cards: cards, position: .early, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .middle, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .late, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .smallBlind, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .bigBlind, expectedAction: .raise)

		testMoreThanOneRaise(cards: cards, position: .early, expectedAction: .raise)
		testMoreThanOneRaise(cards: cards, position: .middle, expectedAction: .raise)
		testMoreThanOneRaise(cards: cards, position: .late, expectedAction: .raise)
		testMoreThanOneRaise(cards: cards, position: .smallBlind, expectedAction: .raise)
		testMoreThanOneRaise(cards: cards, position: .bigBlind, expectedAction: .raise)
		
		testOneRaise_afterFirstRound(cards: cards, expectedAction: .raise)
		testMoreThanOneRaise_afterFirstRound(cards: cards, expectedAction: .raise)
	}

	// MARK: - Help Methods

	func randomHand() -> [Card] {
		guard let hand = hands.randomElement() else {
			XCTFail()
			return []
		}

		return hand
	}
}
