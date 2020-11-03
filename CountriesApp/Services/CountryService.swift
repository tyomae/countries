//
//  CountryService.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

import UIKit

protocol CountryService {
	func getCountries(completion: @escaping((Result<[Country], APIError>) -> Void))
}

class CountryServiceImpl: BaseNetworkService, CountryService {
	
	func getCountries(completion: @escaping((Result<[Country], APIError>) -> Void)) {
		request(method: .GET, completion: completion)
	}
}
