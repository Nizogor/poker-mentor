//
//  OpponentsActionsType.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 07.05.2020.
//

enum OpponentsActionsType {
	case allFold
	case oneCalls
	case twoOrMoreCall
	case oneRaisesAndOtherFold
	case oneRaisesAndAtLeastOneCalls
	case twoOrMoreRaise

	init(actions: [ActionType]) {
		let raises = actions.filter { $0 == .raise }
		let calls = actions.filter { $0 == .call }

		switch (UInt(raises.count), UInt(calls.count)) {
		case (0, 0):
			self = .allFold
		case (0, 1):
			self = .oneCalls
		case (0, 2...):
			self = .twoOrMoreCall
		case (1, 0):
			self = .oneRaisesAndOtherFold
		case (1, 1...):
			self = .oneRaisesAndAtLeastOneCalls
		case (_, _):
			self = .twoOrMoreRaise
		}
	}
}
