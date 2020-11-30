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
		self.property = R.string.localizable.area()
		if let stringScore = NumberFormatter.common.string(from: value as NSNumber) {
			self.value = "\(stringScore) " + R.string.localizable.km()
		} else {
			self.value = "\(value) " + R.string.localizable.km()
		}
	}
}
