//
//  SettingsSettingsViewController.swift
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

	private let tabImageDark = #imageLiteral(resourceName: "gear_black")
	private let tabImageLight = #imageLiteral(resourceName: "gear_white")

    // MARK: - Construction

    required init(presenter: SettingsPresenterProtocol) {
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
		setupNavigationItem()
		setupTabBarItem()
		updateAppearance()
	}

	private func setupNavigationItem() {
		navigationItem.title = screenName
	}

	private func setupTabBarItem() {
		tabBarItem.title = screenName
		tabBarItem.image = #imageLiteral(resourceName: "gear_gray")
	}

	private func updateAppearance() {
		switch traitCollection.userInterfaceStyle {
		case .dark:
			tabBarItem.selectedImage = tabImageLight
		default:
			tabBarItem.selectedImage = tabImageDark
		}
	}
}

// MARK: - SettingsPresenterDelegate

extension SettingsViewController: SettingsPresenterDelegate {

}
