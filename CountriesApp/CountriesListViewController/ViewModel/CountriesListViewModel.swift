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
	private var countriesDict = [String : [Country]]()
	
	var countries = [Country]()
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
		for country in countries {
			let firstCountryLetter = String(country.name.prefix(1))
			if self.countriesDict[firstCountryLetter] != nil {
				self.countriesDict[firstCountryLetter]?.append(country)
			} else {
				self.countriesDict[firstCountryLetter] = [country]
			}
		}
		let keys = self.countriesDict.keys.sorted()
		for key in keys {
			if let countries = self.countriesDict[key] {
				var countryViewModels = [CellViewModel]()
				for country in countries {
					let countryViewModel = CountryCellViewModelImpl(countryName: country.name, regionName: country.region, countryCode: country.countryCode)
					countryViewModels.append(countryViewModel)
				}
				sections.append(Section(title: key, cellViewModels: countryViewModels))
			}
		}
		self.stateHandler?(.dataLoaded)
	}
	
	func getCountrybyIndexPath(indexPath: IndexPath)-> Country? {
		let keyByIndexPath = self.countriesDict.keys.sorted()[indexPath.section]
		let countriesByKey = countriesDict[keyByIndexPath]
		return countriesByKey?[indexPath.row]
	}
}
