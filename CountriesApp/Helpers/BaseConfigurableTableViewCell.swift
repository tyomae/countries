//
//  BaseConfigurableTableViewCell.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit.UITableViewCell

class BaseConfigurableTableViewCell: UITableViewCell, TableCellConfigurable {
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.commonInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.commonInit()
	}

	private func commonInit() {
		self.selectionStyle = .none
		self.setup()
	}

	func setup() {
		fatalError("Must be overriden")
	}

	func configure(with data: TableCellType) {
		fatalError("Must be overriden")
	}
}
