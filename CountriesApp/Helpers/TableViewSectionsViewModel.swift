//
//  TableViewSectionsViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import Foundation

import Foundation

protocol TableViewSectionsViewModel: ViewModel {
	var sections: [TableSection] { get }
	var cellTypes: [TableCellType] { get }

	func indexPath(for cell: TableCellContent) -> IndexPath?
}

extension TableViewSectionsViewModel {
	var cellTypes: [TableCellType] {
		Array(Set(self.sections.flatMap { $0.cells }.map { $0.dataType }))
	}

	func indexPath(for cell: TableCellContent) -> IndexPath? {
		guard let sectionIndex = self.sections.firstIndex(where: { $0.cells.contains(cell) }),
			let cellIndex = self.sections[sectionIndex].cells.firstIndex(of: cell) else {
				return nil
		}
		return IndexPath(row: cellIndex, section: sectionIndex)
	}
}
