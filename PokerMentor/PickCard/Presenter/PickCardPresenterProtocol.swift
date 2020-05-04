//
//  PickCardPresenterProtocol.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import PokerMentorKit

protocol PickCardPresenterProtocol {
	var isDoneEnabled: Bool { get }
	var title: String { get }
	var sections: [PresentedPickCardSection] { get }

	func didSelectItem(indexPath: IndexPath)
	func doneButtonTap()
}
