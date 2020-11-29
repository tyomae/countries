//
//  CountryEntity.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation
import RealmSwift

class CountryEntity: Object {

	@objc dynamic var name: String = ""
	@objc dynamic var capital: String = ""
	@objc dynamic var region: String = ""
	@objc dynamic var subregion: String = ""
	@objc dynamic var population: Int = 0
	@objc dynamic var countryCode: String = ""
	@objc dynamic var area: Double = 0
	@objc dynamic var timezone: String = ""
	@objc dynamic var isFavourite: Bool = false
	@objc dynamic var location: LocationEntity?
	let currencies = List<CurrencyEntity>()

	convenience init(name: String,
					 capital: String,
					 region: String,
					 subregion: String,
					 population: Int,
					 countryCode: String,
					 area: Double,
					 timezone: String,
					 isFavourite: Bool,
					 location: Location?) {
		self.init()
		self.name = name
		self.capital = capital
		self.region = region
		self.subregion = subregion
		self.population = population
		self.countryCode = countryCode
		self.area = area
		self.timezone = timezone
		self.isFavourite = isFavourite
		if let location = location {
			self.location = LocationEntity(countryCode: countryCode, latitude: location.lat, longitude: location.lon)
		}
	}
	
	override class func primaryKey() -> String? {
		"countryCode"
	}
}
