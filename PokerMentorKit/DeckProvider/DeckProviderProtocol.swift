//
//  DeckProviderProtocol.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

public protocol DeckProviderProtocol: class {
	func fullDeck() -> [Card]
	func allCards(with suit: SuitType) -> [Card]
	func allSuits() -> [SuitType]
	func allRanks() -> [RankType]
}
