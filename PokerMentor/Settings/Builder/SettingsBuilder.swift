//
//  SettingsBuilder.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class SettingsBuilder {

    // MARK: - Methods
    
    func buildModule() -> UIViewController {
        let interactor = SettingsInteractor()
        let router = SettingsRouter()

        let presenter = SettingsPresenter(interactor: interactor, router: router)
        let viewController = SettingsViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
