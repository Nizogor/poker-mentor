//
//  SessionSessionInteractor.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class SessionInteractor {

    // MARK: - Properties

    weak var delegate: SessionInteractorDelegate?
}

// MARK: - SessionInteractorProtocol

extension SessionInteractor: SessionInteractorProtocol {

}
