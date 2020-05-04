//
//  SessionRouter.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class SessionRouter {

	// MARK: - Properties

    weak var viewController: UIViewController?

	// MARK: - Private Properties

	private let pickCardBuilder: PickCardBuilder

	// MARK: - Construction

	init(pickCardBuilder: PickCardBuilder) {
		self.pickCardBuilder = pickCardBuilder
	}
}

extension SessionRouter: SessionRouterProtocol {
	func showPickCard() {
		let pickCardViewController = pickCardBuilder.buildModule(phase: .preFlop)

		viewController?.navigationController?.pushViewController(pickCardViewController, animated: true)
	}
}
