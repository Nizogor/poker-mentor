//
//  DeckProvider.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

public class DeckProvider {

	// MARK: - Construction

	public init() {

	}
}

extension DeckProvider: DeckProviderProtocol {
	public func fullDeck() -> [Card] {
		return allSuits().flatMap(allCards)
	}

	public func allCards(with suit: SuitType) -> [Card] {
		return allRanks().map { Card(suit: suit, rank: $0) }
	}

	public func allSuits() -> [SuitType] {
		return [.hearts, .diamonds, .clubs, .spades]
	}

	public func allRanks() -> [RankType] {
		return [.ace, .king, .queen, .jack, .ten, .nine, .eight, .seven, .six, .five, .four, .three, .two]
	}
}
