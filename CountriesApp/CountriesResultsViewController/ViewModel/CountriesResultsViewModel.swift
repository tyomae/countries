//
//  CountriesResultsViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 10.11.2020.
//

import Foundation

final class CountriesResultsViewModelImpl: ViewModel {
	
	var stateHandler: ((State) -> Void)?
	var filteredCountries = [CountryEntity]()
	var cellViewModels = [CountryCellViewModel]()
	private var countries = [CountryEntity]()
	
	enum State {
		case dataUpdated
	}
	
	enum Action {
		case searchTextDidChanged(text: String)
	}
	
	init(countries: [CountryEntity]) {
		self.countries = countries
		self.updateCellViewModels()
	}
	
	private func updateCellViewModels() {
		self.cellViewModels.removeAll()
		for country in filteredCountries {
			let cellViewModel = CountryCellViewModelImpl(countryName: country.name, regionName: country.region, countryCode: country.countryCode)
			self.cellViewModels.append(cellViewModel)
		}
		self.stateHandler?(.dataUpdated)
	}
	
	private func filterCountries(searchText: String) {
		self.filteredCountries = countries.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
		self.updateCellViewModels()
	}
	
	func process(action: Action) {
		switch action {
			case .searchTextDidChanged(let text):
				self.filterCountries(searchText: text)
		}
	}
}
