//
//  UITableView+Register.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit.UITableView

extension UITableView {
	func register<ViewModel: TableViewSectionsViewModel>(sectionsViewModel: ViewModel) {
		sectionsViewModel.cellTypes.forEach {
			self.register($0.cellClass, forCellReuseIdentifier: $0.reuseId)
		}
	}
}
