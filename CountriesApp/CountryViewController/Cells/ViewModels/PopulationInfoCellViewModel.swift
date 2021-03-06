//
//  PopulationInfoViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 05.11.2020.
//

import Foundation

final class PopulationInfoCellViewModel: BaseCountryInfoCellViewModel, CellViewModel {
	let property: String
	let value: String

	init(value: Int) {
		if let stringScore = NumberFormatter.common.string(from: value as NSNumber) {
			self.value = stringScore
		} else {
			self.value = String(value)
		}
		self.property = R.string.localizable.population()
	}
}
