//
//  PickCardPresenterDelegate.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import PokerMentorKit

protocol PickCardPresenterDelegate: class {
	func updateDoneButton()
	func updateTitle()
	func updateSections()
}
