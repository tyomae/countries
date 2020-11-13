//
//  LocationEntity.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation
import RealmSwift

class LocationEntity: Object {
	
	@objc dynamic var countryCode: String = ""
	@objc dynamic var latitude: Double = 0
	@objc dynamic var longitude: Double = 0

	convenience init(countryCode: String, latitude: Double, longitude: Double) {
		self.init()
		self.countryCode = countryCode
		self.latitude = latitude
		self.longitude = longitude
	}
	
	override class func primaryKey() -> String? {
		"countryCode"
	}
}
