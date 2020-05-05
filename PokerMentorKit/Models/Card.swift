//
//  Card.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import Foundation

public struct Card {
	public let suit: SuitType
	public let rank: RankType
}

extension Card: CustomStringConvertible {
	public var description: String {
		return "\(rank.description)\(suit.description)"
	}
}
