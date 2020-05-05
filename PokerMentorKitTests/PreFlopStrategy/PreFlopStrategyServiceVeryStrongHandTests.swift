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
		
		testOneRaiseAndOtherFold_whenInEarlyPosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndOtherFold_whenInMiddlePosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndOtherFold_whenInLatePosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndOtherFold_whenInSmallBlindPosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndOtherFold_whenInBigBlindPosition(cards: cards, expectedAction: .raise)
		
		testOneRaiseAndAtLeastOneCall_whenInEarlyPosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall_whenInMiddlePosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall_whenInLatePosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall_whenInSmallBlindPosition(cards: cards, expectedAction: .raise)
		testOneRaiseAndAtLeastOneCall_whenInBigBlindPosition(cards: cards, expectedAction: .raise)
		
		testMoreThanOneRaise_whenInEarlyPosition(cards: cards, expectedAction: .raise)
		testMoreThanOneRaise_whenInMiddlePosition(cards: cards, expectedAction: .raise)
		testMoreThanOneRaise_whenInLatePosition(cards: cards, expectedAction: .raise)
		testMoreThanOneRaise_whenInSmallBlindPosition(cards: cards, expectedAction: .raise)
		testMoreThanOneRaise_whenInBigBlindPosition(cards: cards, expectedAction: .raise)
		
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
