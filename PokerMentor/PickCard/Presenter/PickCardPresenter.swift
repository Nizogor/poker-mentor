//
//  PickCardPresenter.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import PokerMentorKit

class PickCardPresenter {

    // MARK: - Properties
    
	weak var delegate: PickCardPresenterDelegate? {
		didSet {
			delegate?.updateDoneButton()
			delegate?.updateTitle()
			delegate?.updateSections()
		}
	}

	// MARK: - Private Properties

    private let interactor: PickCardInteractorProtocol
    private let router: PickCardRouterProtocol

	private let phase: PickCardPhase
	
	private let allSuits: [SuitType]
	private let fullDeck: [Card]
	private let pickedCards: [Card]

	private let presentedPickedCards: [PresentedCard]
	private var presentedNewCards: [PresentedCard]

    // MARK: - Construction

	init(interactor: PickCardInteractorProtocol,
		 router: PickCardRouterProtocol,
		 deckProvider: DeckProviderProtocol,
		 phase: PickCardPhase,
		 pickedCards: [Card] = []) {
		self.interactor = interactor
		self.router = router

		self.phase = phase
		self.pickedCards = pickedCards

		presentedPickedCards = pickedCards.map { PresentedCard(suit: $0.suit, rank: $0.rank) }

		let placeholder = PresentedCard(suit: nil, rank: nil)
		allSuits = deckProvider.allSuits()
		fullDeck = deckProvider.fullDeck()

		switch phase {
		case .preFlop:
			let newCardsCount = 2
			presentedNewCards = Array(repeating: placeholder, count: newCardsCount)
		case .flop:
			let newCardsCount = 3
			presentedNewCards = Array(repeating: placeholder, count: newCardsCount)
		case .turn, .river:
			presentedNewCards = [placeholder]
		}
    }
}

// MARK: - PickCardPresenterProtocol

extension PickCardPresenter: PickCardPresenterProtocol {

	var isDoneEnabled: Bool {
		return !presentedNewCards.contains { $0.suit == nil || $0.rank == nil }
	}

	var title: String {
		switch phase {
		case .preFlop:
			return "Pick your Pre-flop hand"
		case .flop:
			return "Pick Flop cards"
		case .turn:
			return "Pick Turn card"
		case .river:
			return "Pick River card"
		}
	}

	var presentedCards: [PresentedCard] {
		return presentedPickedCards + presentedNewCards
	}

	var sections: [PresentedPickCardSection] {
		return presentedNewCards.map { presentedCard -> PresentedPickCardSection in
			switch (presentedCard.suit, presentedCard.rank) {
			case (.none, _):
				return PresentedPickCardSection.suits(allSuits)
			case (.some(let suit), .none):
				let sectionCards = fullDeck.filter { card -> Bool in
					card.suit == suit && !presentedCards.contains { $0.suit == card.suit && $0.rank == card.rank }
				}
				.map { PresentedCard(suit: $0.suit, rank: $0.rank) }

				return PresentedPickCardSection.cards(sectionCards)
			case (.some(_), .some(_)):
				return PresentedPickCardSection.card(presentedCard)
			}
		}
	}

	func didSelectItem(indexPath: IndexPath) {
		let section = sections[indexPath.section]

		switch section {
		case .suits(let suits):
			let suit = suits[indexPath.row]
			presentedNewCards[indexPath.section] = PresentedCard(suit: suit, rank: nil)
		case .cards(let cards):
			let card = cards[indexPath.row]
			presentedNewCards[indexPath.section] = card
		case .card:
			presentedNewCards[indexPath.section] = PresentedCard(suit: nil, rank: nil)
		}

		delegate?.updateSections()
		delegate?.updateDoneButton()
	}

	func doneButtonTap() {

	}
}

// MARK: - PickCardInteractorDelegate

extension PickCardPresenter: PickCardInteractorDelegate {

}
