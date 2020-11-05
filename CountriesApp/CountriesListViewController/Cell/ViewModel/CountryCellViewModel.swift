//
//  CountryCellViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

import UIKit

protocol CountryCellViewModel {
	var countryName: String { get }
	var regionName: String { get }
	var emojiFlag: String { get }
}

final class CountryCellViewModelImpl: CountryCellViewModel, CellViewModel {
	let countryName: String
	let regionName: String
	let emojiFlag: String
	
	init(countryName: String, regionName: String, countryCode: String) {
		self.countryName = countryName
		self.regionName = regionName
		self.emojiFlag = TextUtilities.emojiFlag(from: countryCode)
	}
}
