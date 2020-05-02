//
//  SettingsSettingsPresenter.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class SettingsPresenter {

    // MARK: - Properties
    
    weak var delegate: SettingsPresenterDelegate?

    let interactor: SettingsInteractorProtocol
    let router: SettingsRouterProtocol

    // MARK: - Construction

    init(interactor: SettingsInteractorProtocol, router: SettingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {

}

// MARK: - SettingsInteractorDelegate

extension SettingsPresenter: SettingsInteractorDelegate {

}