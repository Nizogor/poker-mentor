//
//  Container+Setup.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02.05.2020.
//

import Swinject

extension Container {
	func setup() {
		register(TabBarBuilder.self) { _ in
			TabBarBuilder()
		}
	}
}
