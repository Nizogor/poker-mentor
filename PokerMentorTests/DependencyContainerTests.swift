//
//  DependencyContainerTests.swift
//  PokerMentorTests
//
//  Created by Nikita Teplyakov on 02.05.2020.
//

import XCTest
@testable import PokerMentor
import PokerMentorKit
import Swinject

class DependencyContainerTests: XCTestCase {

	let dependencyContainer: Container = {
		let container = Container()
		container.setup()

		return container
	}()

	override class func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
	}

	func testContainer() {
		XCTAssertNotNil(dependencyContainer.resolve(DeckProviderProtocol.self))
		XCTAssertNotNil(dependencyContainer.resolve(PickCardBuilder.self))
		XCTAssertNotNil(dependencyContainer.resolve(SessionBuilder.self))
		XCTAssertNotNil(dependencyContainer.resolve(SettingsBuilder.self))
		XCTAssertNotNil(dependencyContainer.resolve(TabBarBuilder.self))
	}
}

