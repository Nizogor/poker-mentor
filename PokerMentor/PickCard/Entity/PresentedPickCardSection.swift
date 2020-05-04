//
//  PresentedPickCardSection.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import PokerMentorKit

enum PresentedPickCardSection {
	case suits([SuitType])
	case cards([PresentedCard])
	case card(PresentedCard)
}
