//
//  PickCardBuilder.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit
import PokerMentorKit
import Swinject

class PickCardBuilder {

	// MARK: - Private Properties

	private let dependencyContainer: Container

	// MARK: - Construction

	init(dependencyContainer: Container) {
		self.dependencyContainer = dependencyContainer
	}

    // MARK: - Methods
    
	func buildModule(phase: PickCardPhase) -> UIViewController {
		let deckProvider = dependencyContainer.resolve(DeckProviderProtocol.self)!

        let interactor = PickCardInteractor()
        let router = PickCardRouter()

		let presenter = PickCardPresenter(interactor: interactor,
										  router: router,
										  deckProvider: deckProvider,
										  phase: phase)
        let viewController = PickCardViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
