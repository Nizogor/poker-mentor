//
//  HandTests.swift
//  PokerMentorKitTests
//
//  Created by Nikita Teplyakov on 05.05.2020.
//

import XCTest
@testable import PokerMentorKit

class TestHandsProvider {

	private let deckProvider: DeckProviderProtocol

	init(deckProvider: DeckProviderProtocol) {
		self.deckProvider = deckProvider
	}

	/// AA, KK, QQ, AK
	func allVeryStrongHands() -> [[Card]] {
		let pairs = allPairs(from: [.ace, .king, .queen])
		let allSuited = allSuitedHands(from: [.ace, .king])
		let allUnsuited = allUnsuitedHands(from: [.ace, .king])

		return pairs + allSuited + allUnsuited
	}

	/// JJ, TT, 99, AQ, AJs
	func allStrongHands() -> [[Card]] {
		let pairs = allPairs(from: [.jack, .ten, .nine])
		let allSuitedAQ = allSuitedHands(from: [.ace, .queen])
		let allUnsuitedAQ = allUnsuitedHands(from: [.ace, .queen])
		let allSuitedAJ = allSuitedHands(from: [.ace, .jack])

		return pairs + allSuitedAQ + allUnsuitedAQ + allSuitedAJ
	}

	/// AT, KQ, AJo
	func allMediumHands() -> [[Card]] {
		let allSuitedAT = allSuitedHands(from: [.ace, .ten])
		let allUnsuitedAT = allUnsuitedHands(from: [.ace, .ten])
		let allUnsuitedAJ = allUnsuitedHands(from: [.ace, .jack])

		return allSuitedAT + allUnsuitedAT + allUnsuitedAJ
	}

	/// 88, 77, 66, 55, 44, 33, 22, KJs, KTs, QJs, QTs, JTs, T9s
	func allSpeculativeHands() -> [[Card]] {
		let pairs = allPairs(from: [.eight, .seven, .six, .five, .four, .three, .two])
		let allSuitedKJ = allSuitedHands(from: [.king, .jack])
		let allSuitedKT = allSuitedHands(from: [.king, .ten])
		let allSuitedQJ = allSuitedHands(from: [.queen, .jack])
		let allSuitedQT = allSuitedHands(from: [.queen, .ten])
		let allSuitedJT = allSuitedHands(from: [.jack, .ten])
		let allSuitedT9 = allSuitedHands(from: [.ten, .nine])

		return pairs + allSuitedKJ + allSuitedKT + allSuitedQJ + allSuitedQT + allSuitedJT + allSuitedT9
	}

	/// A9s, A8s, A7s, A6s, A5s, A4s, A3s, A2s, K9s, 98s, 87s, KJo, KTo, QJo, QTo, JTo
	func allMixedHands() -> [[Card]] {
		let allSuitedA9 = allSuitedHands(from: [.ace, .nine])
		let allSuitedA8 = allSuitedHands(from: [.ace, .eight])
		let allSuitedA7 = allSuitedHands(from: [.ace, .seven])
		let allSuitedA6 = allSuitedHands(from: [.ace, .six])
		let allSuitedA5 = allSuitedHands(from: [.ace, .five])
		let allSuitedA4 = allSuitedHands(from: [.ace, .four])
		let allSuitedA3 = allSuitedHands(from: [.ace, .three])
		let allSuitedA2 = allSuitedHands(from: [.ace, .two])
		let allSuitedK9 = allSuitedHands(from: [.king, .nine])
		let allSuited98 = allSuitedHands(from: [.nine, .eight])
		let allSuited87 = allSuitedHands(from: [.eight, .seven])
		let allUnsuitedKJ = allUnsuitedHands(from: [.king, .jack])
		let allUnsuitedKT = allUnsuitedHands(from: [.king, .ten])
		let allUnsuitedQJ = allUnsuitedHands(from: [.queen, .jack])
		let allUnsuitedQT = allUnsuitedHands(from: [.queen, .ten])
		let allUnsuitedJT = allUnsuitedHands(from: [.jack, .ten])

		return allSuitedA9 + allSuitedA8 + allSuitedA7 + allSuitedA6 + allSuitedA5 + allSuitedA4 +
			allSuitedA3 + allSuitedA2 + allSuitedK9 + allSuited98 + allSuited87 + allUnsuitedKJ +
			allUnsuitedKT + allUnsuitedQJ + allUnsuitedQT + allUnsuitedJT
	}

	func allPairs(from ranks: [RankType]) -> [[Card]] {
		let rankGroups = ranks.map { rank in
			deckProvider.allSuits.map { Card(suit: $0, rank: rank) }
		}

		var pairs = [[Card]]()

		/*
		ranks = A
		rankGroup = A♥ A♦ A♣ A♠
		A♥A♦ A♥A♣ A♥A♠
		A♦A♥ A♦A♣ A♦A♠
		A♣A♥ A♣A♦ A♣A♠
		A♠A♥ A♠A♦ A♠A♣
		*/

		rankGroups.forEach { group in
			group.forEach { card in
				group.forEach {
					if card.suit != $0.suit {
						pairs.append([card, $0])
					}
				}
			}
		}

		return pairs
	}

	func allSuitedHands(from ranks: [RankType]) -> [[Card]] {
		let suitGroups = deckProvider.allSuits.map { suit in
			ranks.map { rank in
				Card(suit: suit, rank: rank)
			}
		}

		var hands = [[Card]]()

		/*
		ranks = A K Q
		suitGroup = A♥ K♥ Q♥
		A♥K♥ A♥Q♥
		K♥A♥ K♥Q♥
		Q♥A♥ Q♥K♥
		*/

		suitGroups.forEach { group in
			group.forEach { card in
				group.forEach {
					if card.rank != $0.rank {
						hands.append([card, $0])
					}
				}
			}
		}

		return hands
	}

	func allUnsuitedHands(from ranks: [RankType]) -> [[Card]] {
		let cards = ranks.flatMap { rank in
			deckProvider.allSuits.map { Card(suit: $0, rank: rank) }
		}

		var hands = [[Card]]()

		/*
		ranks = A K Q
		cards = A♥ A♦ A♣ A♠ K♥ K♦ K♣ K♠ Q♥ Q♦ Q♣ Q♠
		A♥K♦ A♥K♣ A♥K♠ A♥Q♦ A♥Q♣ A♥Q♠
		K♥A♦ K♥A♣ K♥A♠ K♥Q♦ K♥Q♣ K♥Q♠
		Q♥A♦ Q♥A♣ Q♥A♠ Q♥K♦ Q♥K♣ Q♥K♠
		*/

		cards.forEach { card in
			cards.forEach {
				if card.rank != $0.rank && card.suit != $0.suit {
					hands.append([card, $0])
				}
			}
		}

		return hands
	}
}
