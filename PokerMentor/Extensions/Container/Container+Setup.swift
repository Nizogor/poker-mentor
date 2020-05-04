//
//  Container+Setup.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02.05.2020.
//

import Swinject
import PokerMentorKit

extension Container {
	func setup() {
		let deckProvider = DeckProvider()

		register(DeckProviderProtocol.self) { _ in
			deckProvider
		}

		register(PickCardBuilder.self) { _ in
			PickCardBuilder(dependencyContainer: self)
		}

		register(SessionBuilder.self) { _ in
			SessionBuilder(dependencyContainer: self)
		}

		register(SettingsBuilder.self) { _ in
			SettingsBuilder()
		}

		register(TabBarBuilder.self) { _ in
			TabBarBuilder(dependencyContainer: self)
		}
	}
}
