//
//  PreFlopHandRecognizeServiceProtocol.swift
//  PokerMentorKit
//
//  Created by Nikita Teplyakov on 05.05.2020.
//

protocol PreFlopHandRecognizeServiceProtocol: class {
	func handType(cards: [Card]) -> PreFlopHandType
}
