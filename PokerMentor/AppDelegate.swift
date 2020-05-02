//
//  AppDelegate.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 02.05.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window?.rootViewController = UIViewController()
		window?.makeKeyAndVisible()

		return true
	}
}

