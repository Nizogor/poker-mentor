//
//  UICollectionViewCell+ReuseIdentifier.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03.05.2020.
//

import UIKit

extension UICollectionViewCell {
	static func reuseIdentifier() -> String {
		return NSStringFromClass(Self.self).components(separatedBy: ".").last!
	}
}
