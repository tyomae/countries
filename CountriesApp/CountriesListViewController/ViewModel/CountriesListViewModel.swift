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
		case error(errorString: String)
		case loading
	}
	
	enum Action {
		case addCountry(countryCode: String)
		case deleteCountry(countryCode: String)
	}
	
	var stateHandler: ((State) -> Void)?
	var sections = [Section]()
	var countries = [CountryEntity]()
	var favouritesCountryService = FavouriteCountryServiceImpl()
	private var countriesDict = [String : [CountryEntity]]()
	private var countryService = CountryServiceImpl()
	
	init() {
		self.getCountries()
		self.favouritesCountryService.addListener { [weak self] in
			self?.getCountries()
			self?.stateHandler?(.dataLoaded)
		}
	}
	
	func process(action: Action) {
		switch action {
			case .deleteCountry(let countryCode):
				self.favouritesCountryService.removeFavouriteCountry(countryCode: countryCode)
			case .addCountry(let countryCode):
				self.favouritesCountryService.addCountryToFavourite(countryCode: countryCode)
		}
	}
	
	func getCountries() {
		self.stateHandler?(.loading)
		self.countryService.getCountries { [weak self] in
			guard let self = self else { return }
			switch $0 {
				case let .success(countries):
					self.countries = self.sortCountriesByAlphabet(countries: countries)
					self.generateSectionsDict()
					if countries.isEmpty == false {
						self.stateHandler?(.dataLoaded)
					}
				case let .failure(error):
					self.stateHandler?(.error(errorString: error.stringError))
			}
		}
	}
	
	private func generateSectionsDict() {
		self.sections.removeAll()
		self.countriesDict.removeAll()
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
				var countryViewModels = [CountryCellViewModelImpl]()
				for country in countries {
					let isFavourite = self.favouritesCountryService.isFavouriteCountry(countryCode: country.countryCode)
					let countryViewModel = CountryCellViewModelImpl(countryName: country.name,
																	regionName: country.region,
																	countryCode: country.countryCode,
																	isFavourite: isFavourite)
					countryViewModels.append(countryViewModel)
				}
				self.sections.append(Section(title: key, cellViewModels: countryViewModels))
			}
		}
	}
	
	func getCountrybyIndexPath(indexPath: IndexPath)-> CountryEntity? {
		let keyByIndexPath = self.countriesDict.keys.sorted()[indexPath.section]
		let countriesByKey = self.countriesDict[keyByIndexPath]
		return countriesByKey?[indexPath.row]
	}
	
	private func sortCountriesByAlphabet(countries: [CountryEntity]) -> [CountryEntity] {
		countries.sorted { (country1, country2) -> Bool in
			return (country1.name.localizedCaseInsensitiveCompare(country2.name) == .orderedAscending)
		}
	}
}
