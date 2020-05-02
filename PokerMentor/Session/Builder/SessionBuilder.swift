//
//  SessionSessionBuilder.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class SessionBuilder {

    // MARK: - Methods
    
    func buildModule() -> UIViewController {
        let interactor = SessionInteractor()
        let router = SessionRouter()

        let presenter = SessionPresenter(interactor: interactor, router: router)
        let viewController = SessionViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
