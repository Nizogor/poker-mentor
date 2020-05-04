//
//  SessionBuilder.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit
import Swinject

class SessionBuilder {

	// MARK: - Private Properties

	private let dependencyContainer: Container

	// MARK: - Construction

	init(dependencyContainer: Container) {
		self.dependencyContainer = dependencyContainer
	}

    // MARK: - Methods
    
    func buildModule() -> UIViewController {
		let pickCardBuilder = dependencyContainer.resolve(PickCardBuilder.self)!

        let interactor = SessionInteractor()
        let router = SessionRouter(pickCardBuilder: pickCardBuilder)

        let presenter = SessionPresenter(interactor: interactor, router: router)
        let viewController = SessionViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
