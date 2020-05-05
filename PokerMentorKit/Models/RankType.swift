//
//  RankType.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import Foundation

public enum RankType {
	case ace
	case king
	case queen
	case jack
	case ten
	case nine
	case eight
	case seven
	case six
	case five
	case four
	case three
	case two
}

extension RankType: CustomStringConvertible {
	public var description: String {
		switch self {
		case .ace:
			return "A"
		case .king:
			return "K"
		case .queen:
			return "Q"
		case .jack:
			return "J"
		case .ten:
			return "10"
		case .nine:
			return "9"
		case .eight:
			return "8"
		case .seven:
			return "7"
		case .six:
			return "6"
		case .five:
			return "5"
		case .four:
			return "4"
		case .three:
			return "3"
		case .two:
			return "2"
		}
	}
}
