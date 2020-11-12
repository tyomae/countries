//
//  CountryService.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

import UIKit

protocol CountryService {
	func getCountries(completion: @escaping((Result<[CountryEntity], APIError>) -> Void))
}

class CountryServiceImpl: BaseNetworkService, CountryService {

	private var savedCountries = Array(mainRealm.objects(CountryEntity.self))

	func getCountries(completion: @escaping((Result<[CountryEntity], APIError>) -> Void)) {
		if savedCountries.isEmpty == false {
			completion(Result.success(self.savedCountries))
		}
		
		request(method: .GET) { [weak self] (result: Result<[Country], APIError>) in
			guard let self = self else { return }
			switch result {
				
				case let .success(countries):
			self.saveCountries(countries: countries)
					
				case .failure(let error):
					if self.savedCountries.isEmpty {
						completion(Result.failure(error))
						return
					}
			}
			
			completion(Result.success(self.savedCountries))
		}
	}
	
	private func saveCountries(countries: [Country]) {
		for country in countries {
			let countryEntity = CountryEntity(name: country.name,
											  capital: country.capital,
											  region: country.region,
											  subregion: country.subregion,
											  population: country.population,
											  countryCode: country.countryCode,
											  area: country.area ?? 0,
											  timezone: country.timezone,
											  isFavourite: false,
											  location: country.location)
			if let currencies = country.currencies {
				for currency in currencies {
					countryEntity.currencies.append(CurrencyEntity(code: currency.code,
																   name: currency.name,
																   symbol: currency.symbol))
				}
			}
			realmWrite {
				mainRealm.add(countryEntity, update: .all)
			}
		}
	}
}
