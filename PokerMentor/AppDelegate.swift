//
//  AppDelegate.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02.05.2020.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	// MARK: - Properties

	var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

	// MARK: - Private Properties

	private let dependancyContainer: Container = {
		let container = Container()
		container.setup()

		return container
	}()

	// MARK: - Methods

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let builder = dependancyContainer.resolve(TabBarBuilder.self)

		window?.rootViewController = builder?.buildModule()
		window?.makeKeyAndVisible()

		return true
	}
}

