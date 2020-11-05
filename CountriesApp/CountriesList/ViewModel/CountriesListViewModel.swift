//
//  CountriesListViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import Foundation

final class CountriesListViewModelImpl: ViewModel {
	
	struct Section {
		let title: String
		let cellViewModels: [CellViewModel]
	}
	
	enum State {
		case dataLoaded
	}
	
	var stateHandler: ((State) -> Void)?
	var sections = [Section]()
	
	private var countries = [Country]()
	private var countryService = CountryServiceImpl()
	
	init() {
		self.getCountries()
	}
	
	private func getCountries() {
		countryService.getCountries { [weak self] in
			guard let self = self else { return }
			self.countries.removeAll()
			switch $0 {
				case let .success(countries):
					self.countries = countries
					self.getSectionsDict()
				case let .failure(error):
					//TODO: make error
					print(error)
			}
		}
	}
	
	private func getSectionsDict() {
		var countriesDict = [String : [Country]]()
		for country in countries {
			let firstCountryLetter = String(country.name.prefix(1))
			if countriesDict[firstCountryLetter] != nil {
				countriesDict[firstCountryLetter]?.append(country)
			} else {
				countriesDict[firstCountryLetter] = [country]
			}
		}
		let keys = countriesDict.keys.sorted()
		for key in keys {
			if let countries = countriesDict[key] {
				var countryViewModels = [CellViewModel]()
				for country in countries {
					let countryViewModel = CountryViewModelImpl(countryName: country.name, regionName: country.region, countryCode: country.countryCode)
					countryViewModels.append(countryViewModel)
				}
				sections.append(Section(title: key, cellViewModels: countryViewModels))
			}
		}
		self.stateHandler?(.dataLoaded)
	}
}
