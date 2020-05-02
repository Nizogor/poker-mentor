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

	// MARK: - Construction

	init(sessionBuilder: SessionBuilder) {
		self.sessionBuilder = sessionBuilder
	}

	// MARK: - Private Methods

	private func setupViewControllers() {
		let sessionViewController = sessionBuilder.buildModule()

		viewController?.setViewControllers([sessionViewController], animated: false)
	}
}

extension TabBarRouter: TabBarRouterProtocol {

}
