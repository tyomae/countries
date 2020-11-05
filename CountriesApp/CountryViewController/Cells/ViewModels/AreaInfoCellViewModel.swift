//
//  AreaInfoViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 05.11.2020.
//

import Foundation

final class AreaInfoCellViewModel: BaseCountryInfoCellViewModel, CellViewModel {
	let property: String
	let value: String

	init(property: String, value: Double) {
		self.property = property + ":"
		self.value = String(value)
	}
}
