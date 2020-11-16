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
	@objc dynamic var addingDate = Date()
	
	convenience init(countryCode: String) {
		self.init()
		self.countryId = countryCode
		self.addingDate = Date()
	}
	
	override class func primaryKey() -> String? {
		"countryId"
	}
}
