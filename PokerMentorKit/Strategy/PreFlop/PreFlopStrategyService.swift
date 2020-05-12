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
			return actionForMediumHand(position: position, opponentActions: opponentsActions)
		case .kingQueenSuited:
			return actionForKingAndQueenSuitedHand(position: position, opponentActions: opponentsActions)
		case .speculative:
			return actionForSpeculativeHand(position: position, opponentActions: opponentsActions)
		default:
			fatalError()
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

	private func actionForMediumHand(position: PositionType,
									 opponentActions: [ActionType]) -> ActionType {
		let raises = opponentActions.filter { $0 == .raise }

		if raises.isEmpty && position != .early {
			return .raise
		} else if raises.count == 1 && position == .bigBlind {
			return .call
		} else {
			return .fold
		}
	}

	// MARK: King And Queen Suited Hand

	private func actionForKingAndQueenSuitedHand(position: PositionType,
												 opponentActions: [ActionType]) -> ActionType {
		let raises = opponentActions.filter { $0 == .raise }
		let calls = opponentActions.filter { $0 == .call }

		let oneRaise = raises.count == 1

		if raises.isEmpty && position != .early {
			return .raise
		} else if (oneRaise && position == .bigBlind) || (oneRaise && !calls.isEmpty) {
			return .call
		} else {
			return .fold
		}
	}

	// MARK: Speculative Hand

	private func actionForSpeculativeHand(position: PositionType, opponentActions: [ActionType]) -> ActionType {
		let actionsType = OpponentsActionsType(actions: opponentActions)

		switch (actionsType, position) {
		case (.allFold, .late), (.allFold, .smallBlind), (.allFold, .bigBlind):
			return .raise
		case (.oneCalls, .late), (.oneCalls, .smallBlind), (.twoOrMoreCall, .early), (.twoOrMoreCall, .middle),
			 (.twoOrMoreCall, .late), (.twoOrMoreCall, .smallBlind), (.oneRaisesAndOtherFold, .bigBlind),
			 (.oneRaisesAndAtLeastOneCalls, _):
			return .call
		case (.oneCalls, .bigBlind), (.twoOrMoreCall, .bigBlind):
			return .check
		default:
			return .fold
		}
	}

	// MARK: - After First Round

	func actionAfterFirstRound(cards: [Card], opponentsActions: [ActionType]) -> ActionType {
		let handType = handRecognizer.handType(cards: cards)
		let raises = opponentsActions.filter { $0 == .raise }

		switch handType {
		case .veryStrong:
			return .raise
		case .strong:
			return .call
		case .medium, .kingQueenSuited, .speculative:
			return raises.count > 1 ? .fold : .call
		default:
			return .fold
		}
	}
}
