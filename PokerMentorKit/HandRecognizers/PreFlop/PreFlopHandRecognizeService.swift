//
//  PreFlopHandRecognizeService.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 05.05.2020.
//

class PreFlopHandRecognizeService {

	/// AA, KK, QQ, AK
	let veryStrongHands: Set<Set<RankType>> = [[.ace, .ace], [.king, .king], [.queen, .queen], [.ace, .king]]

	/// JJ, TT, 99, AQ
	let strongHands: Set<Set<RankType>> = [[.jack, .jack], [.ten, .ten], [.nine, .nine], [.ace, .queen]]

	/// AJs
	let strongSuitedHand: Set<RankType> = [.ace, .jack]

	/// AT
	let mediumHand: Set<RankType> = [.ace, .ten]

	/// AJo, KQo
	let meduimUnsuitedHands: Set<Set<RankType>> = [[.ace, .jack], [.king, .queen]]

	/// KQs
	let kingQueenSuitedHand: Set<RankType> = [.king, .queen]

	/// 88, 77, 66, 55, 44, 33, 22
	let speculativeHands: Set<Set<RankType>> = [[.eight, .eight], [.seven, .seven], [.six, .six], [.five, .five],
												[.four, .four], [.three, .three], [.two, .two]]

	/// KJs, KTs, QJs, QTs, JTs, T9s
	let speculativeSuitedHands: Set<Set<RankType>> = [[.king, .jack], [.king, .ten], [.queen, .jack],
													  [.queen, .ten], [.jack, .ten], [.ten, .nine]]

	/// A9s, A8s, A7s, A6s, A5s, A4s, A3s, A2s, K9s, 98s, 87s
	let mixedSuitedHands: Set<Set<RankType>> = [[.ace, .nine], [.ace, .eight], [.ace, .seven], [.ace, .six],
												[.ace, .five], [.ace, .four], [.ace, .three], [.ace, .two],
												[.king, .nine], [.nine, .eight], [.eight, .seven]]

	/// KJo, KTo, QJo, QTo, JTo
	let mixedUnsuitedHands: Set<Set<RankType>> = [[.king, .jack], [.king, .ten], [.queen, .jack],
												  [.queen, .ten], [.jack, .ten]]
}

extension PreFlopHandRecognizeService: PreFlopHandRecognizeServiceProtocol {

	func handType(cards: [Card]) -> PreFlopHandType {
		let suits = cards.map { $0.suit }
		let ranks = cards.map { $0.rank }
		let set = Set(ranks)
		let isSuited = Set(suits).count == 1

		if veryStrongHands.contains(set) {
			return .veryStrong
		} else if strongHands.contains(set) || (isSuited && strongSuitedHand == set) {
			return .strong
		} else if mediumHand == set || (!isSuited && meduimUnsuitedHands.contains(set)) {
			return .medium
		} else if isSuited && kingQueenSuitedHand == set {
			return .kingQueenSuited
		} else if speculativeHands.contains(set) || (isSuited && speculativeSuitedHands.contains(set)) {
			return .speculative
		} else if (isSuited && mixedSuitedHands.contains(set)) || (!isSuited && mixedUnsuitedHands.contains(set)) {
			return .mixed
		} else {
			return .other
		}
	}
}
