//
//  SuitType.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import Foundation

public enum SuitType {
	case hearts
	case diamonds
	case clubs
	case spades
}

extension SuitType: CustomStringConvertible {
	public var description: String {
		switch self {
		case .hearts:
			return "♥"
		case .diamonds:
			return "♦"
		case .clubs:
			return "♣"
		case .spades:
			return "♠"
		}
	}
}
