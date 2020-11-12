//
//  LocationEntity.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation
import RealmSwift

class LocationEntity: Object {
	@objc dynamic var latitude: Double = 0
	@objc dynamic var longitude: Double = 0

	convenience init(latitude: Double, longitude: Double) {
		self.init()
		self.latitude = latitude
		self.longitude = longitude
	}
}
