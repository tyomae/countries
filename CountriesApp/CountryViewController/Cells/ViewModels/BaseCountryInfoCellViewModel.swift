//
//  BaseCountryInfoViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 05.11.2020.
//

import Foundation

protocol BaseCountryInfoCellViewModel {
	var property: String { get }
	var value: String { get }
}

final class BaseCountryInfoViewModelImpl: BaseCountryInfoCellViewModel, CellViewModel {
	let property: String
	let value: String

	init(property: String, value: String) {
		self.property = property + ":"
		self.value = value
	}
}
