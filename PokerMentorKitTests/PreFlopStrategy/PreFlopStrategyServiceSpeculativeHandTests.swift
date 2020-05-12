//
//  PreFlopStrategyServiceSpeculativeHandTests.swift
//  PokerMentorKitTests
//
//  Created by Nikita Teplyakov on 07.05.2020.
//

import XCTest
@testable import PokerMentorKit

class PreFlopStrategyServiceSpeculativeHandTests: PreFlopStrategyServiceTests {

	lazy var hands = testHandsProvider.allSpeculativeHands()

	// MARK: - First Round

	func testSpeculativeHandStrategy() {
		let cards = randomHand()

		testAllFold(cards: cards, position: .early, expectedAction: .fold)
		testAllFold(cards: cards, position: .middle, expectedAction: .fold)
		testAllFold(cards: cards, position: .late, expectedAction: .raise)
		testAllFold(cards: cards, position: .smallBlind, expectedAction: .raise)
		testAllFold(cards: cards, position: .bigBlind, expectedAction: .raise)

		testOneCall(cards: cards, position: .early, expectedAction: .fold)
		testOneCall(cards: cards, position: .middle, expectedAction: .fold)
		testOneCall(cards: cards, position: .late, expectedAction: .call)
		testOneCall(cards: cards, position: .smallBlind, expectedAction: .call)
		testOneCall(cards: cards, position: .bigBlind, expectedAction: .check)

		testTwoOrMoreCalls(cards: cards, position: .early, expectedAction: .call)
		testTwoOrMoreCalls(cards: cards, position: .middle, expectedAction: .call)
		testTwoOrMoreCalls(cards: cards, position: .late, expectedAction: .call)
		testTwoOrMoreCalls(cards: cards, position: .smallBlind, expectedAction: .call)
		testTwoOrMoreCalls(cards: cards, position: .bigBlind, expectedAction: .check)

		testOneRaiseAndOtherFold(cards: cards, position: .early, expectedAction: .fold)
		testOneRaiseAndOtherFold(cards: cards, position: .middle, expectedAction: .fold)
		testOneRaiseAndOtherFold(cards: cards, position: .late, expectedAction: .fold)
		testOneRaiseAndOtherFold(cards: cards, position: .smallBlind, expectedAction: .fold)
		testOneRaiseAndOtherFold(cards: cards, position: .bigBlind, expectedAction: .call)

		testOneRaiseAndAtLeastOneCall(cards: cards, position: .early, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .middle, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .late, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .smallBlind, expectedAction: .call)
		testOneRaiseAndAtLeastOneCall(cards: cards, position: .bigBlind, expectedAction: .call)

		testMoreThanOneRaise(cards: cards, position: .early, expectedAction: .fold)
		testMoreThanOneRaise(cards: cards, position: .middle, expectedAction: .fold)
		testMoreThanOneRaise(cards: cards, position: .late, expectedAction: .fold)
		testMoreThanOneRaise(cards: cards, position: .smallBlind, expectedAction: .fold)
		testMoreThanOneRaise(cards: cards, position: .bigBlind, expectedAction: .fold)

		testOneRaise_afterFirstRound(cards: cards, expectedAction: .call)
		testMoreThanOneRaise_afterFirstRound(cards: cards, expectedAction: .fold)
	}

	// MARK: - Help Methods

	func randomHand() -> [Card] {
		guard let hand = hands.randomElement() else {
			XCTFail()
			return []
		}

		return hand
	}

	func timeConversion(s: String) -> String {
		let string = String(s.suffix(2))
		let decimal = Decimal(integerLiteral: 1)
		let x = NSDecimalNumber(decimal: pow(decimal, 2)).intValue

		(0..<10).reduce(0, { x, y in

		})

		return string
	}
}


