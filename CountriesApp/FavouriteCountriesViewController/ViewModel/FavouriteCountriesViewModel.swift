//
//  FavouriteCountriesViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation

final class FavouriteCountriesViewModel: ViewModel {
	
	var stateHandler: ((State) -> Void)?
	var favouritesCountries = [CountryEntity]()
	var cellViewModels = [CountryCellViewModel]()
	var favouriteCountryService = FavouriteCountryServiceImpl()
	
	enum State {
		case dataUpdated
		case emptyList
	}
	
	enum Action {
		case deleteCountry(countryCode: String)
	}
	
	init() {
		self.updateCellViewModels()
		self.stateHandler?(.emptyList)
		self.favouriteCountryService.addListener { [weak self] in
			self?.updateCellViewModels()
			self?.stateHandler?(.dataUpdated)
			self?.stateHandler?(.emptyList)
		}
	}
	
	func process(action: Action) {
		switch action {
			case .deleteCountry(let countryCode):
				self.favouriteCountryService.removeFavouriteCountry(countryCode: countryCode)
		}
	}
	
	private func updateCellViewModels() {
		self.favouritesCountries = favouriteCountryService.getFavouriteCountries()
		self.cellViewModels.removeAll()
		for country in favouritesCountries {
			let cellViewModel = CountryCellViewModelImpl(countryName: country.name, regionName: country.region, countryCode: country.countryCode, isFavourite: false)
			self.cellViewModels.append(cellViewModel)
		}
		self.stateHandler?(.dataUpdated)
	}
}
