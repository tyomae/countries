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
		sections.append(Section(title: "Basic", cellViewModels: [
			BaseCountryInfoViewModelImpl(property: "Capital", value: country.capital),
			BaseCountryInfoViewModelImpl(property: "Region", value: country.region),
			BaseCountryInfoViewModelImpl(property: "Subregion", value: country.subregion)
		]))
		sections.append(Section(title: "Numerical characteristics", cellViewModels: [
			AreaInfoCellViewModel(value: country.area),
			PopulationInfoCellViewModel(value: country.population),
			BaseCountryInfoViewModelImpl(property: "Timezone", value: country.timezone)
		]))
		for (index, currency) in country.currencies.enumerated() {
			let title = index == 0 ? "Currencies" : nil
			sections.append(Section(title: title, cellViewModels: [
				BaseCountryInfoViewModelImpl(property: "Code", value: currency.code),
				BaseCountryInfoViewModelImpl(property: "Name", value: currency.name),
				BaseCountryInfoViewModelImpl(property: "Symbol", value: currency.symbol)
			]))
		}
		if let latitude = country.location?.latitude, let longitude = country.location?.longitude {
			sections.append(Section(title: "Country location", cellViewModels:
										[MapCellViewModelImpl(latitude: latitude, longitude: longitude)]))
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
		stateHandler?(.isFavouriteUpdated)
	}
}
