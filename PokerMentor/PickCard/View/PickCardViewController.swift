//
//  PickCardViewController.swift
//  PokerMentor
//
//  Created by Nikita Teplyakov on 03/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class PickCardViewController: UIViewController {

    // MARK: - Private Properties

	private let collectionView: UICollectionView

    private let presenter: PickCardPresenterProtocol

	private let spacing: CGFloat = 20

    // MARK: - Construction

    required init(presenter: PickCardPresenterProtocol) {
        self.presenter = presenter

		let layout = UICollectionViewFlowLayout()
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)

		setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationController?.navigationBar.tintColor = UIColor.blackWhite
	}

	// MARK: - Private Methods

	private func setup() {
		setupView()
		setupNavigationItem()
		setupCollectionView()
	}

	private func setupView() {
		view.backgroundColor = UIColor.whiteBlack
	}

	private func setupNavigationItem() {
		let action = #selector(doneButtonTap)
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: action)
	}

	private func setupCollectionView() {
		view.addSubview(collectionView)
		collectionView.register(CardCollectionViewCell.self,
								forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier())
		collectionView.autoPinEdge(toSuperviewMargin: .top, withInset: spacing / 2)
		collectionView.autoPinEdge(toSuperviewEdge: .left, withInset: spacing / 2)
		collectionView.autoPinEdge(toSuperviewEdge: .right, withInset: spacing / 2)
		collectionView.autoPinEdge(toSuperviewMargin: .bottom, withInset: spacing / 2)
		collectionView.backgroundColor = .clear
		collectionView.dataSource = self
		collectionView.delegate = self
	}

	// MARK: - Actions

	@objc private func doneButtonTap() {
		presenter.doneButtonTap()
	}
}

// MARK: - PickCardPresenterDelegate

extension PickCardViewController: PickCardPresenterDelegate {
	func updateDoneButton() {
		navigationItem.rightBarButtonItem?.isEnabled = presenter.isDoneEnabled
	}

	func updateTitle() {
		navigationItem.title = presenter.title
	}

	func updateSections() {
		collectionView.reloadData()
	}
}

// MARK: - UICollectionViewDataSource

extension PickCardViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return presenter.sections.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let section = presenter.sections[section]

		switch section {
		case .suits(let suits):
			return suits.count
		case .cards(let cards):
			return cards.count
		case .card:
			return 1
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let section = presenter.sections[indexPath.section]
		let reuseIdentifier = CardCollectionViewCell.reuseIdentifier()
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

		guard let cardCell = cell as? CardCollectionViewCell else { return cell }

		switch section {
		case .suits(let suits):
			let suit = suits[indexPath.row]
			cardCell.setup(suit: suit)
		case .cards(let cards):
			let card = cards[indexPath.row]
			cardCell.setup(card: card)
		case .card(let card):
			cardCell.setup(card: card)
		}

		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension PickCardViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter.didSelectItem(indexPath: indexPath)
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PickCardViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let sectionsCount = collectionView.numberOfSections
		let itemsCount = collectionView.numberOfItems(inSection: indexPath.section)
		let sectionHeight = collectionView.bounds.height / CGFloat(sectionsCount)

		let numberOfLines: Int
		switch (sectionsCount, itemsCount) {
		case (1, 5...13), (2, 5...13):
			numberOfLines = 3
		case (3, 5...13):
			numberOfLines = 2
		default:
			numberOfLines = 1
		}

		let height = sectionHeight / CGFloat(numberOfLines) - spacing

		let itemsInLine = (CGFloat(itemsCount) / CGFloat(numberOfLines)).rounded(.up)
		let width = collectionView.bounds.width / itemsInLine - spacing

		return CGSize(width: width, height: height)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return spacing
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return spacing
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		let sideInset = spacing / 2
		return UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
	}
}
