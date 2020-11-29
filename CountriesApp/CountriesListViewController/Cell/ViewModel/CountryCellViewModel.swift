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
	var isFavourite: Bool { get }
}

final class CountryCellViewModelImpl: CountryCellViewModel, CellViewModel {
	let countryName: String
	let regionName: String
	let emojiFlag: String
	let isFavourite: Bool
	
	init(countryName: String, regionName: String, countryCode: String, isFavourite: Bool) {
		self.countryName = countryName
		self.regionName = regionName
		self.emojiFlag = TextUtilities.emojiFlag(from: countryCode)
		self.isFavourite  = isFavourite
	}
}
