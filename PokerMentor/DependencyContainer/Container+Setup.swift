//
//  Container+Setup.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02.05.2020.
//

import Swinject

extension Container {
	func setup() {
		register(SessionBuilder.self) { _ in
			SessionBuilder()
		}

		register(SettingsBuilder.self) { _ in
			SettingsBuilder()
		}

		register(TabBarBuilder.self) { _ in
			TabBarBuilder(dependencyContainer: self)
		}
	}
}
