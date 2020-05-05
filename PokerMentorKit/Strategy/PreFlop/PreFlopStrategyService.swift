//
//  PreFlopStrategyService.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 04.05.2020.
//

class PreFlopStrategyService {

	// MARK: - Private Properties

	private let handRecognizer: PreFlopHandRecognizeServiceProtocol

	// MARK: - Construction

	init(handRecognizer: PreFlopHandRecognizeServiceProtocol) {
		self.handRecognizer = handRecognizer
	}

	// MARK: - Methods

	func actionInFirstRound(cards: [Card], position: PositionType, opponentsActions: [ActionType]) -> ActionType {
		let handType = handRecognizer.handType(cards: cards)

		switch handType {
		case .veryStrong:
			return .raise
		case .strong:
			return actionForStrongHand(position: position, opponentActions: opponentsActions)
		case .medium:
			return actionForMediumHand(cards: cards, position: position, opponentActions: opponentsActions)
		default:
			fatalError()
		}
	}

	func actionAfterFirstRound(cards: [Card], opponentsActions: [ActionType]) -> ActionType {
		let handType = handRecognizer.handType(cards: cards)

		switch handType {
		case .veryStrong:
			return .raise
		case .strong:
			return .call
		default:
			return .fold
		}
	}

	// MARK: - Private Methods

	// MARK: Strong Hand

	private func actionForStrongHand(position: PositionType, opponentActions: [ActionType]) -> ActionType {
		let raises = opponentActions.filter { $0 == .raise }
		let calls = opponentActions.filter { $0 == .call }

		let oneRaise = raises.count == 1

		if raises.isEmpty || (oneRaise && calls.isEmpty && position != .early) {
			return .raise
		} else if oneRaise && !calls.isEmpty {
			return .call
		} else {
			return .fold
		}
	}

	// MARK: Medium Hand

	private func actionForMediumHand(cards: [Card],
									 position: PositionType,
									 opponentActions: [ActionType]) -> ActionType {
		let raises = opponentActions.filter { $0 == .raise }

		let ranks = cards.map { $0.rank }
		let suits = cards.map { $0.suit }

		let isKingQueen = Set(ranks) == [.king, .queen]
		let isSuited = Set(suits).count == 1
		let isExeption = isKingQueen && isSuited

		let atLeastOneCall = opponentActions.contains(.call)
		let oneRaise = raises.count == 1

		switch position {
		case .early:
			if oneRaise && atLeastOneCall && isExeption {
				return .call
			} else {
				return .fold
			}
		case .bigBlind:
			if oneRaise {
				return .call
			} else {
				return .raise
			}
		case .middle, .late, .smallBlind:
			if oneRaise && atLeastOneCall && isExeption {
				return .call
			} else if oneRaise {
				return .fold
			} else {
				return .raise
			}
		}
	}
}
