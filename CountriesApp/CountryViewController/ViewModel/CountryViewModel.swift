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
	}
	
	var sections = [Section]()
	var stateHandler: ((State) -> Void)?
	let country: Country
	
	init(country: Country) {
		self.country = country
		sections.append(Section(title: "Basic", cellViewModels: [
			BaseCountryInfoViewModelImpl(property: "Capital", value: country.capital),
			BaseCountryInfoViewModelImpl(property: "Region", value: country.region),
			BaseCountryInfoViewModelImpl(property: "Subregion", value: country.subregion)
		]))
		sections.append(Section(title: "Numerical characteristics", cellViewModels: [
			AreaInfoCellViewModel(value: country.area ?? 0),
			PopulationInfoCellViewModel(value: country.population),
			BaseCountryInfoViewModelImpl(property: "Timezone", value: country.timezone)
		]))
		guard let currencies = country.currencies else { return }
		for (index, currency) in currencies.enumerated() {
			let title = index == 0 ? "Currencies" : nil
			sections.append(Section(title: title, cellViewModels: [
				BaseCountryInfoViewModelImpl(property: "Code", value: currency.code),
				BaseCountryInfoViewModelImpl(property: "Name", value: currency.name),
				BaseCountryInfoViewModelImpl(property: "Symbol", value: currency.symbol)
			]))
		}
		self.stateHandler?(.dataLoaded)
	}
}
