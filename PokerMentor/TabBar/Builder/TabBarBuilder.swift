//
//  TabBarTabBarBuilder.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit
import Swinject

class TabBarBuilder {

	// MARK: - Private Properties

	private let dependencyContainer: Container

	init(dependencyContainer: Container) {
		self.dependencyContainer = dependencyContainer
	}

    // MARK: - Methods
    
    func buildModule() -> UIViewController {
		let sessionBuilder = dependencyContainer.resolve(SessionBuilder.self)!
		let settingsBuilder = dependencyContainer.resolve(SettingsBuilder.self)!

        let interactor = TabBarInteractor()
		let router = TabBarRouter(sessionBuilder: sessionBuilder, settingsBuilder: settingsBuilder)

        let presenter = TabBarPresenter(interactor: interactor, router: router)
        let viewController = TabBarViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
