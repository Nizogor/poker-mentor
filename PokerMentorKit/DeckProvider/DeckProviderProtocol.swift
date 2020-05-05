//
//  DeckProviderProtocol.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

public protocol DeckProviderProtocol: class {
	var fullDeck: [Card] { get }
	var allSuits: [SuitType] { get }
	var allRanks: [RankType] { get }

	func allCards(with suit: SuitType) -> [Card]
}
