//
//  CountryViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 05.11.2020.
//

import Foundation

final class CountryViewModelImpl: ViewModel {
	
	struct Section {
		let title: String?
		let cellViewModels: [CellViewModel]
	}
	
	enum State {
		case dataLoaded
		case isFavouriteUpdated
	}
	
	enum Action {
		case changeFavourite
	}
	
	var sections = [Section]()
	var stateHandler: ((State) -> Void)?
	let country: CountryEntity
	var isFavourite: Bool
	private let favouriteCountryService = FavouriteCountryServiceImpl()
	
	init(country: CountryEntity, isFavourite: Bool) {
		self.country = country
		self.isFavourite = isFavourite
		
		self.sections.append(Section(title: R.string.localizable.basic(), cellViewModels: [
			BaseCountryInfoViewModelImpl(property: R.string.localizable.capital(), value: country.capital),
			BaseCountryInfoViewModelImpl(property: R.string.localizable.region(), value: country.region),
			BaseCountryInfoViewModelImpl(property: R.string.localizable.subregion(), value: country.subregion)
		]))
		self.sections.append(Section(title: R.string.localizable.numerical_characteristics(), cellViewModels: [
			AreaInfoCellViewModel(value: country.area),
			PopulationInfoCellViewModel(value: country.population),
			BaseCountryInfoViewModelImpl(property: R.string.localizable.timezone(), value: country.timezone)
		]))
		for (index, currency) in country.currencies.enumerated() {
			let title = index == 0 ? R.string.localizable.currencies() : nil
			self.sections.append(Section(title: title, cellViewModels: [
				BaseCountryInfoViewModelImpl(property: R.string.localizable.code(), value: currency.code),
				BaseCountryInfoViewModelImpl(property: R.string.localizable.name(), value: currency.name),
				BaseCountryInfoViewModelImpl(property: R.string.localizable.symbol(), value: currency.symbol)
			]))
		}
		if let latitude = country.location?.latitude, let longitude = country.location?.longitude {
			self.sections.append(Section(title: R.string.localizable.country_location(), cellViewModels:
										[MapCellViewModelImpl(latitude: latitude,
															  longitude: longitude)]))
		}
		self.stateHandler?(.dataLoaded)
	}
	
	func process(action: Action) {
		switch action {
			case .changeFavourite:
				self.updateFavourite()
		}
	}
	
	private func updateFavourite() {
		self.isFavourite.toggle()
		if self.isFavourite == true {
			self.favouriteCountryService.addCountryToFavourite(countryCode: country.countryCode)
		} else {
			self.favouriteCountryService.removeFavouriteCountry(countryCode: country.countryCode)
		}
		self.stateHandler?(.isFavouriteUpdated)
	}
}
