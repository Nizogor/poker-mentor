//
//  SessionPresenter.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class SessionPresenter {

    // MARK: - Properties
    
    weak var delegate: SessionPresenterDelegate?

    let interactor: SessionInteractorProtocol
    let router: SessionRouterProtocol

    // MARK: - Construction

    init(interactor: SessionInteractorProtocol, router: SessionRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - SessionPresenterProtocol

extension SessionPresenter: SessionPresenterProtocol {
	func startButtonTap() {
		router.showPickCard()
	}
}

// MARK: - SessionInteractorDelegate

extension SessionPresenter: SessionInteractorDelegate {

}
