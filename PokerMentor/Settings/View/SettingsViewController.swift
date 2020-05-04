//
//  SettingsViewController.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Private Properties

	private let screenName = "Settings"

    private let presenter: SettingsPresenterProtocol

    // MARK: - Construction

    required init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)

		setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - Private Methods

	private func setup() {
		setupNavigationItem()
		setupTabBarItem()
	}

	private func setupNavigationItem() {
		navigationItem.title = screenName
	}

	private func setupTabBarItem() {
		tabBarItem = UITabBarItem(title: screenName, image: #imageLiteral(resourceName: "gear_gray"), selectedImage: #imageLiteral(resourceName: "gear"))
	}
}

// MARK: - SettingsPresenterDelegate

extension SettingsViewController: SettingsPresenterDelegate {

}
