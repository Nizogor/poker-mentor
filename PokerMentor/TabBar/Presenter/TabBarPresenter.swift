//
//  TabBarTabBarPresenter.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class TabBarPresenter {

    // MARK: - Properties
    
    weak var delegate: TabBarPresenterDelegate?

    let interactor: TabBarInteractorProtocol
    let router: TabBarRouterProtocol

    // MARK: - Construction

    init(interactor: TabBarInteractorProtocol, router: TabBarRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - TabBarPresenterProtocol

extension TabBarPresenter: TabBarPresenterProtocol {

}

// MARK: - TabBarInteractorDelegate

extension TabBarPresenter: TabBarInteractorDelegate {

}