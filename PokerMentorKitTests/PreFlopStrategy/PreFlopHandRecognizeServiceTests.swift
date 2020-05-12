//
//  PreFlopHandRecognizeServiceTests.swift
//  PokerMentorKitTests
//
//  Created by Nikita Teplyakov on 05.05.2020.
//

import XCTest
@testable import PokerMentorKit

class PreFlopHandRecognizeServiceTests: XCTestCase {

	let sut = PreFlopHandRecognizeService()
	lazy var testHandsProvider = TestHandsProvider(deckProvider: DeckProvider())

	override class func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
	}

	func testHands() {
		let veryStrongHands = testHandsProvider.allVeryStrongHands()
		let strongHands = testHandsProvider.allStrongHands()
		let mediumHands = testHandsProvider.allMediumHands()
		let kingQueenSuitedHands = testHandsProvider.allKingAndQueenSuitedHands()
		let speculativeHands = testHandsProvider.allSpeculativeHands()
		let mixedHands = testHandsProvider.allMixedHands()
		
		veryStrongHands.forEach { testHand(actualType: .veryStrong, cards: $0) }
		strongHands.forEach { testHand(actualType: .strong, cards: $0) }
		mediumHands.forEach { testHand(actualType: .medium, cards: $0) }
		kingQueenSuitedHands.forEach { testHand(actualType: .kingQueenSuited, cards: $0) }
		speculativeHands.forEach { testHand(actualType: .speculative, cards: $0) }
		mixedHands.forEach { testHand(actualType: .mixed, cards: $0) }

		[strongHands, mediumHands, kingQueenSuitedHands, speculativeHands, mixedHands].flatMap { $0 }
			.forEach { testHand(fakeType: .veryStrong, cards: $0) }

		[veryStrongHands, mediumHands, kingQueenSuitedHands, speculativeHands, mixedHands].flatMap { $0 }
			.forEach { testHand(fakeType: .strong, cards: $0) }

		[veryStrongHands, strongHands, kingQueenSuitedHands, speculativeHands, mixedHands].flatMap { $0 }
			.forEach { testHand(fakeType: .medium, cards: $0) }

		[veryStrongHands, strongHands, mediumHands, speculativeHands, mixedHands].flatMap { $0 }
		.forEach { testHand(fakeType: .kingQueenSuited, cards: $0) }

		[veryStrongHands, strongHands, mediumHands, kingQueenSuitedHands, mixedHands].flatMap { $0 }
			.forEach { testHand(fakeType: .speculative, cards: $0) }

		[veryStrongHands, strongHands, mediumHands, kingQueenSuitedHands, speculativeHands].flatMap { $0 }
			.forEach { testHand(fakeType: .mixed, cards: $0) }
	}

	func testHand(actualType: PreFlopHandType, cards: [Card]) {
		let handType = sut.handType(cards: cards)
		XCTAssertEqual(handType, actualType, "actual type: \(actualType), unexpected type: \(handType), cards: \(cards.description)")
	}

	func testHand(fakeType: PreFlopHandType, cards: [Card]) {
		let handType = sut.handType(cards: cards)
		XCTAssertNotEqual(handType, fakeType, "fake type: \(fakeType), cards: \(cards.description)")
	}
}
