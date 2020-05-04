//
//  CardView.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import UIKit
import PokerMentorKit

class CardView: UIView {

	// MARK: - Properties

	var rank: RankType? {
		didSet { updateRank() }
	}

	var suit: SuitType? {
		didSet {
			updateSuit()
			updateRank()
		}
	}

	// MARK: - Private Properties

	private let containerView = UIView()
	private let topLeftLabel = UILabel()
	private let rankLabel = UILabel()
	private let bottomRightLabel = UILabel()

	private let suitWidthMultiplier: CGFloat = 0.45

	// MARK: - Construction

	required init() {
		suit = nil

		super.init(frame: .zero)

		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - View Life Cycle

	override func layoutSubviews() {
		super.layoutSubviews()

		let minSide = min(containerView.bounds.width, containerView.bounds.height)
		containerView.layer.borderWidth = 1
		containerView.layer.cornerRadius = minSide / 5
	}

	// MARK: - Private Methods

	private func setup() {
		setupContainerView()
		setupTopLeftLabel()
		setupBottomRightLabel()
		setupRankLabel()
	}

	private func setupContainerView() {
		addSubview(containerView)
		containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 0, relation: .greaterThanOrEqual)
		containerView.autoPinEdge(toSuperviewEdge: .left, withInset: 0, relation: .greaterThanOrEqual)
		containerView.autoPinEdge(toSuperviewEdge: .right, withInset: 0, relation: .greaterThanOrEqual)
		containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0, relation: .greaterThanOrEqual)
		containerView.autoCenterInSuperview()
		containerView.autoMatch(.width, to: .height, of: containerView, withMultiplier: 2.5 / 3.5)
		containerView.layer.borderColor = UIColor.blackWhite?.cgColor
		containerView.backgroundColor = .white
	}

	private func setupTopLeftLabel() {
		containerView.addSubview(topLeftLabel)
		topLeftLabel.autoPinEdge(toSuperviewEdge: .top)
		topLeftLabel.autoPinEdge(toSuperviewEdge: .left)
		topLeftLabel.autoMatch(.width, to: .width, of: containerView, withMultiplier: suitWidthMultiplier)
		topLeftLabel.autoMatch(.height, to: .width, of: containerView, withMultiplier: suitWidthMultiplier)

		setupLabel(topLeftLabel)
	}

	private func setupBottomRightLabel() {
		containerView.addSubview(bottomRightLabel)
		bottomRightLabel.autoPinEdge(toSuperviewEdge: .right)
		bottomRightLabel.autoPinEdge(toSuperviewEdge: .bottom)
		bottomRightLabel.autoMatch(.width, to: .width, of: containerView, withMultiplier: suitWidthMultiplier)
		bottomRightLabel.autoMatch(.height, to: .width, of: containerView, withMultiplier: suitWidthMultiplier)

		setupLabel(bottomRightLabel)
	}

	private func setupRankLabel() {
		let rankSideMultiplier: CGFloat = 0.6

		containerView.addSubview(rankLabel)
		rankLabel.autoCenterInSuperview()
		rankLabel.autoMatch(.width, to: .width, of: containerView, withMultiplier: rankSideMultiplier)
		rankLabel.autoMatch(.height, to: .height, of: containerView, withMultiplier: rankSideMultiplier)

		setupLabel(rankLabel)

		updateSuit()
		updateRank()
	}

	private func setupLabel(_ label: UILabel) {
		label.font = UIFont.systemFont(ofSize: 500)
		label.textAlignment = .center
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.textColor = .gray
	}

	private func updateSuit() {
		let text = symbolForSuit()
		topLeftLabel.text = text
		bottomRightLabel.text = text

		switch suit {
		case .hearts, .diamonds:
			topLeftLabel.textColor = .red
			rankLabel.textColor = .red
			bottomRightLabel.textColor = .red
		case .clubs, .spades:
			topLeftLabel.textColor = .black
			rankLabel.textColor = .black
			bottomRightLabel.textColor = .black
		case .none:
			topLeftLabel.text = nil
			rankLabel.textColor = .gray
			bottomRightLabel.text = nil
		}
	}

	private func updateRank() {
		switch rank {
		case .ace:
			rankLabel.text = "A"
		case .king:
			rankLabel.text = "K"
		case .queen:
			rankLabel.text = "Q"
		case .jack:
			rankLabel.text = "J"
		case .ten:
			rankLabel.text = "10"
		case .nine:
			rankLabel.text = "9"
		case .eight:
			rankLabel.text = "8"
		case .seven:
			rankLabel.text = "7"
		case .six:
			rankLabel.text = "6"
		case .five:
			rankLabel.text = "5"
		case .four:
			rankLabel.text = "4"
		case .three:
			rankLabel.text = "3"
		case .two:
			rankLabel.text = "2"
		case .none:
			rankLabel.text = symbolForSuit()
		}
	}

	private func symbolForSuit() -> String? {
		switch suit {
		case .hearts:
			return "♥"
		case .diamonds:
			return "♦"
		case .clubs:
			return "♣"
		case .spades:
			return "♠"
		case .none:
			return nil
		}
	}
}
