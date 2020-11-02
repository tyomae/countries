//
//  BaseRootTableView.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class WillReloadTableView: UITableView {
	var willReload: (() -> Void)?
	
	override func reloadData() {
		self.willReload?()
		super.reloadData()
	}
}

class BaseRootTableView: UIView {
	private(set) weak var tableView: WillReloadTableView!

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}
	
	func setup() {
		// to be overriden
	}
	
	private func commonInit() {
		self.backgroundColor = .systemGray6
		let tableView = WillReloadTableView(frame: .zero, style: .insetGrouped)
		self.addSubview(tableView)
		self.tableView = tableView
		
		tableView.tableFooterView = UIView()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 60
		tableView.backgroundColor = .clear
		tableView.keyboardDismissMode = .onDrag
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		let margins = layoutMarginsGuide
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
		])
		let guide = safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
			guide.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1.0)
		])
		
		self.setup()
	}
}
