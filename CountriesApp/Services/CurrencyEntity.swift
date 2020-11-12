//
//  CurrencyEntity.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation

//var code: String
//var name: String
//var symbol: String

import RealmSwift

class CurrencyEntity: Object {
	@objc dynamic var code: String = ""
	@objc dynamic var name: String = ""
	@objc dynamic var symbol: String = ""

	convenience init(code: String, name: String, symbol: String) {
		self.init()
		self.code = code
		self.name = name
		self.symbol = symbol
	}
}
