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

	init(value: Double) {
		self.property = "Area:"
		if let stringScore = NumberFormatter.common.string(from: value as NSNumber) {
			self.value = "\(stringScore) km²"
		} else {
			self.value = "\(value) km²"
		}
	}
}
