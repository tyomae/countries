//
//  Country.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

import Foundation

struct Country: Decodable {
	var name: String
	var capital: String
	var region: String
	var subregion: String
	var population: Int
	var location: Location?
	var countryCode: String
	var area: Double?
	var timezone: String
	var currencies: [Currency]?
	
	enum CodingKeys: String, CodingKey {
		case name = "name"
		case capital = "capital"
		case region = "region"
		case subregion = "subregion"
		case population = "population"
		case location = "latlng"
		case countryCode = "alpha2Code"
		case area = "area"
		case timezone = "timezones"
		case currencies = "currencies"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try values.decode(String.self, forKey: .name)
		self.capital = try values.decode(String.self, forKey: .capital)
		self.region = try values.decode(String.self, forKey: .region)
		self.subregion = try values.decode(String.self, forKey: .subregion)
		self.population = try values.decode(Int.self, forKey: .population)
		let latlon = try values.decode([Double].self, forKey: .location)
		if latlon.count > 1 {
			self.location = Location(lat: latlon[0], lon: latlon[1])
		}
		self.countryCode = try values.decode(String.self, forKey: .countryCode)
		self.area = try? values.decode(Double.self, forKey: .area)
		let timezones = try values.decode([String].self, forKey: .timezone)
		self.timezone = timezones[0]
		self.currencies = try? values.decode([Currency].self, forKey: .currencies)
	}	
}

