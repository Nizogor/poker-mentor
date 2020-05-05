//
//  PreFlopStrategyServiceStrongHandTests.swift
//  PokerMentorKitTests
//
//  Created by Nikita Teplyakov on 05.05.2020.
//

import XCTest
@testable import PokerMentorKit

class PreFlopStrategyServiceStrongHandTests: PreFlopStrategyServiceTests {

	lazy var hands = testHandsProvider.allStrongHands()

	// MARK: - First Round

	func testStrongHandStrategy() {
		let cards = randomHand()

		testAllFold_whenInEarlyPosition(cards: cards, expectedAction: .raise)
		testAllFold_whenInMiddlePosition(cards: cards, expectedAction: .raise)
		testAllFold_whenInLatePosition(cards: cards, expectedAction: .raise)
		testAllFold_whenInSmallBlindPosition(cards: cards, expectedAction: .raise)
		testAllFold_whenInBigBlindPosition(cards: cards, expectedAction: .raise)

		testOneCall_whenInEarlyPosition(cards: cards, expectedAction: .raise)
		testOneCall_whenInMiddlePosition(cards: cards, expectedAction: .raise)
		testOneCall_whenInLatePosition(cards: cards, expectedAction: .raise)
		testOneCall_whenInSmallBlindPosition(cards: cards, expectedAction: .raise)
		testOneCall_whenInBigBlindPosition(cards: cards, expectedAction: .raise)

		testTwoOrMoreCalls_whenInEarlyPosition(cards: cards, expectedAction: .raise)
		testTwoOrMoreCalls_whenInMiddlePosition(cards: cards, expectedAction: .raise)
		testTwoOrMoreCalls_whenInLatePosition(cards: cards, expectedAction: .raise)
		testTwoOrMoreCalls_whenInSmallBlindPosition(cards: cards, expectedAction: .raise)
		testTwoOrMoreCalls_whenInBigBlindPosition(cards: cards, expectedAction: .raise)

		testOneRaiseAndOtherFold_whenInEarlyPosition(cards: cards, expectedAction: .fold)
		testOneRaiseAndOtherFold_whenInMiddlePosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndOtherFold_whenInLatePosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndOtherFold_whenInSmallBlindPosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndOtherFold_whenInBigBlindPosition(cards: cards, expectedAction: .raise)

		testOneRaiseAndAtLeastOneCall_whenInEarlyPosition(cards: cards, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall_whenInMiddlePosition(cards: cards, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall_whenInLatePosition(cards: cards, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall_whenInSmallBlindPosition(cards: cards, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall_whenInBigBlindPosition(cards: cards, expectedAction: .call)

		testMoreThanOneRaise_whenInEarlyPosition(cards: cards, expectedAction: .fold)
		testMoreThanOneRaise_whenInMiddlePosition(cards: cards, expectedAction: .fold)
		testMoreThanOneRaise_whenInLatePosition(cards: cards, expectedAction: .fold)
		testMoreThanOneRaise_whenInSmallBlindPosition(cards: cards, expectedAction: .fold)
		testMoreThanOneRaise_whenInBigBlindPosition(cards: cards, expectedAction: .fold)

		testOneRaise_afterFirstRound(cards: cards, expectedAction: .call)
		testMoreThanOneRaise_afterFirstRound(cards: cards, expectedAction: .call)
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

