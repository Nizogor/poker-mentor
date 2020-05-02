//
//  DependencyContainerTests.swift
//  PokerMentorTests
//
//  Created by Nikita Teplyakov on 02.05.2020.
//

import XCTest
@testable import PokerMentor
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
		XCTAssertNotNil(dependencyContainer.resolve(TabBarBuilder.self))
	}
}

