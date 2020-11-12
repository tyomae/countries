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
	var countries = [CountryEntity]()
	private var countriesDict = [String : [CountryEntity]]()
	private var countryService = CountryServiceImpl()
	
	init() {
		self.getCountries()
	}
	
	private func getCountries() {
		countryService.getCountries { [weak self] in
			guard let self = self else { return }
			switch $0 {
				case let .success(countries):
					self.countries = countries
					self.generateSectionsDict()
//					if countries.isEmpty == false {
//						self.stateHandler?(.dataLoaded)
//					}
					self.stateHandler?(.dataLoaded)
				case let .failure(error):
					//TODO: make error
					print(error)
			}
		}
	}
	
	private func generateSectionsDict() {
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
	}
	
	func getCountrybyIndexPath(indexPath: IndexPath)-> CountryEntity? {
		let keyByIndexPath = self.countriesDict.keys.sorted()[indexPath.section]
		let countriesByKey = countriesDict[keyByIndexPath]
		return countriesByKey?[indexPath.row]
	}
}
