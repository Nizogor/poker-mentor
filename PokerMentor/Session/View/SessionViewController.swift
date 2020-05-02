//
//  SessionSessionViewController.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit
import PureLayout

class SessionViewController: UIViewController {

    // MARK: - Private Properties

	private let goodLuckLabel = UILabel()
	private let startButton = UIButton()

    private let presenter: SessionPresenterProtocol

	private let tabImageDark = #imageLiteral(resourceName: "coin_black")
	private let tabImageLight = #imageLiteral(resourceName: "coin_white")

    // MARK: - Construction

    required init(presenter: SessionPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)

		setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - Methods

	override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)

		updateAppearance()
	}

	// MARK: - Private Methods

	private func setup() {
		setupTabBarItem()
		setupStartButton()
		setupGoodLuckLabel()
		updateAppearance()
	}

	private func setupStartButton() {
		view.addSubview(startButton)
		startButton.autoSetDimension(.width, toSize: 100)
		startButton.autoAlignAxis(toSuperviewAxis: .vertical)
		startButton.autoPinEdge(toSuperviewMargin: .bottom, withInset: 30)
		startButton.setContentHuggingPriority(.required, for: .vertical)
		startButton.setTitle("Start", for: .normal)
		startButton.setTitleColor(.gray, for: .highlighted)
		startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		startButton.layer.cornerRadius = 6
	}

	private func setupGoodLuckLabel() {
		view.addSubview(goodLuckLabel)
		goodLuckLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
		goodLuckLabel.autoPinEdge(.bottom, to: .top, of: startButton)
		goodLuckLabel.text = "Good Luck!"
		goodLuckLabel.textAlignment = .center
		goodLuckLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
	}

	private func setupTabBarItem() {
		tabBarItem.title = "Session"
		tabBarItem.image = #imageLiteral(resourceName: "coin_gray")
	}

	private func updateAppearance() {
		switch traitCollection.userInterfaceStyle {
		case .dark:
			startButton.backgroundColor = .white
			startButton.setTitleColor(.black, for: .normal)

			goodLuckLabel.textColor = .white

			tabBarItem.selectedImage = tabImageLight
		default:
			startButton.backgroundColor = .black
			startButton.setTitleColor(.white, for: .normal)

			goodLuckLabel.textColor = .black

			tabBarItem.selectedImage = tabImageDark
		}
	}
}

// MARK: - SessionPresenterDelegate

extension SessionViewController: SessionPresenterDelegate {

}
