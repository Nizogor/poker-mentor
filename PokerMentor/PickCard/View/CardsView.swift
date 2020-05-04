//
//  CardsView.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import UIKit

class CardsView: UIView {

	// MARK: - Private Properties

	private let stackView = UIStackView()
	private var cardViews = [CardView]()

	// MARK: - Construction

	required init() {
		super.init(frame: .zero)

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods

	func update(with cards: [PresentedCard]) {
		while cardViews.count > cards.count {
			let lastElement = cardViews.removeLast()
			stackView.removeArrangedSubview(lastElement)
		}

		let lastElement = cardViews.last

		while cardViews.count < cards.count {
			let cardView = CardView()
			cardViews.append(cardView)

			stackView.addArrangedSubview(cardView)

			if let view = lastElement {
				cardView.autoMatch(.width, to: .width, of: view)
			}
		}

		for (index, element) in cardViews.enumerated() {
			element.suit = cards[index].suit
			element.rank = cards[index].rank
		}
	}

	// MARK: - Private Methods

	private func setup() {
		setupStackView()
	}

	private func setupStackView() {
		addSubview(stackView)
		stackView.autoPinEdge(toSuperviewEdge: .top)
		stackView.autoPinEdge(toSuperviewEdge: .bottom)
		stackView.autoMatch(.width, to: .width, of: self, withOffset: 0, relation: .lessThanOrEqual)
		stackView.autoAlignAxis(toSuperviewAxis: .vertical)
		stackView.spacing = 10
	}
}
