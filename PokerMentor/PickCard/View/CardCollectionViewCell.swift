//
//  CardCollectionViewCell.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import UIKit
import PokerMentorKit

class CardCollectionViewCell: UICollectionViewCell {

	// MARK: - Private Properties

	private let cardView = CardView()

	// MARK: - Construction

	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods

	override func prepareForReuse() {
		cardView.suit = nil
		cardView.rank = nil
	}

	func setup(suit: SuitType) {
		cardView.suit = suit
	}

	func setup(card: PresentedCard) {
		cardView.suit = card.suit
		cardView.rank = card.rank
	}

	// MARK: - Private Methods

	private func setup() {
		setupCardView()
	}

	private func setupCardView() {
		addSubview(cardView)
		cardView.autoPinEdgesToSuperviewEdges()
	}
}
