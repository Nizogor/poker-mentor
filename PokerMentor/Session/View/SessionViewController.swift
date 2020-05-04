//
//  SessionViewController.swift
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

    // MARK: - Construction

    required init(presenter: SessionPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)

		setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - View Life Cycle

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.setNavigationBarHidden(true, animated: false)
	}

	// MARK: - Private Methods

	private func setup() {
		setupTabBarItem()
		setupStartButton()
		setupGoodLuckLabel()
	}

	private func setupStartButton() {
		view.addSubview(startButton)
		startButton.autoSetDimension(.width, toSize: 100)
		startButton.autoAlignAxis(toSuperviewAxis: .vertical)
		startButton.autoPinEdge(toSuperviewMargin: .bottom, withInset: 30)
		startButton.setContentHuggingPriority(.required, for: .vertical)
		startButton.setTitle("Start", for: .normal)
		startButton.setTitleColor(UIColor.whiteBlack, for: .normal)
		startButton.setTitleColor(.gray, for: .highlighted)
		startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		startButton.layer.cornerRadius = 6
		startButton.addTarget(self, action: #selector(startButtonTap), for: .touchUpInside)
		startButton.backgroundColor = UIColor.blackWhite
	}

	private func setupGoodLuckLabel() {
		view.addSubview(goodLuckLabel)
		goodLuckLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
		goodLuckLabel.autoPinEdge(.bottom, to: .top, of: startButton)
		goodLuckLabel.text = "Good Luck!"
		goodLuckLabel.textAlignment = .center
		goodLuckLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
		goodLuckLabel.textColor = UIColor.blackWhite
	}

	private func setupTabBarItem() {
		tabBarItem = UITabBarItem(title: "Session", image: #imageLiteral(resourceName: "coin_gray"), selectedImage: #imageLiteral(resourceName: "coin"))
	}

	// MARK: - Actions

	@objc private func startButtonTap() {
		presenter.startButtonTap()
	}
}

// MARK: - SessionPresenterDelegate

extension SessionViewController: SessionPresenterDelegate {

}
