//
//  CountryViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

import UIKit

protocol CountryViewModel {
	var countryName: String { get }
	var regionName: String { get }
	var emojiFlag: String { get }
}

final class CountryViewModelImpl: CountryViewModel {
	let countryName: String
	let regionName: String
	let emojiFlag: String
	
	init(countryName: String, regionName: String, emojiFlag: String) {
		self.countryName = countryName
		self.regionName = regionName
		self.emojiFlag = emojiFlag
	}
}


