//
//  FavouriteCountryEntity.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 13.11.2020.
//

import Foundation
import RealmSwift

class FavouriteCountryEntity: Object {
	@objc dynamic var countryId: String = ""

	convenience init(countryCode: String) {
		self.init()
		self.countryId = countryCode
	}
	
	override class func primaryKey() -> String? {
		"countryId"
	}
}
