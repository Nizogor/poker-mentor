//
//  TabBarTabBarRouter.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class TabBarRouter {

    // MARK: - Properties

	weak var viewController: UITabBarController? {
		didSet { setupViewControllers() }
	}

	// MARK: - Private Properties

	private let sessionBuilder: SessionBuilder
	private let settingsBuilder: SettingsBuilder

	// MARK: - Construction

	init(sessionBuilder: SessionBuilder, settingsBuilder: SettingsBuilder) {
		self.sessionBuilder = sessionBuilder
		self.settingsBuilder = settingsBuilder
	}

	// MARK: - Private Methods

	private func setupViewControllers() {
		let sessionViewController = sessionBuilder.buildModule()
		let settingsViewController = settingsBuilder.buildModule()
		let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

		viewController?.setViewControllers([sessionViewController, settingsNavigationController], animated: false)
	}
}

extension TabBarRouter: TabBarRouterProtocol {

}
