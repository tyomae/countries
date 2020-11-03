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
	
	enum CodingKeys: String, CodingKey {
		case name = "name"
		case capital = "capital"
		case region = "region"
		case subregion = "subregion"
		case population = "population"
		case location = "latlng"
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
	}	
}

