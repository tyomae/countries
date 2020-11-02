//
//  TableCellType.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class TableSection {
	let title: String?
	let cells: [TableCellContent]

	init(title: String?, cells: [TableCellContent]) {
		self.title = title
		self.cells = cells
	}
}

class TableCellContent: Equatable {
	var action: (() -> Void)?
	let dataType: TableCellType

	private let id = UUID().uuidString

	init(dataType: TableCellType, action: (() -> Void)? = nil) {
		self.dataType = dataType
		self.action = action
	}

	static func == (lhs: TableCellContent, rhs: TableCellContent) -> Bool {
		lhs.id == rhs.id
	}
}

enum TableCellType: Hashable, Equatable {
	case countryCell(viewModel: BaseConfigurableTableViewCell)

	var cellClass: BaseConfigurableTableViewCell.Type {
		switch self {
			case .countryCell:
				return BaseConfigurableTableViewCell.self
		}
	}

	var reuseId: String {
		self.cellClass.reuseId
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(self.reuseId)
	}

	static func == (lhs: TableCellType, rhs: TableCellType) -> Bool {
		// Perform .indexOf() on TableCellContent, not on this enum
		lhs.reuseId == rhs.reuseId
	}
}

