//
//  DeckProvider.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

public class DeckProvider: DeckProviderProtocol {

	private(set) public lazy var fullDeck: [Card] = {
		return allSuits.flatMap(allCards)
	}()

	public let allSuits: [SuitType] = [.hearts, .diamonds, .clubs, .spades]

	public let allRanks: [RankType] = [.ace, .king, .queen, .jack, .ten, .nine, .eight,
									   .seven, .six, .five, .four, .three, .two]

	// MARK: - Construction

	public init() {

	}

	// MARK: - Methods

	public func allCards(with suit: SuitType) -> [Card] {
		return allRanks.map { Card(suit: suit, rank: $0) }
	}
}
