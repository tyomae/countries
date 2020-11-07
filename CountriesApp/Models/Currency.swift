//
//  Currency.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 07.11.2020.
//

import Foundation

struct Currency: Decodable {
	var code: String
	var name: String
	var symbol: String
	
//	enum CurrencyKey: CodingKey {
//		case code
//		case name
//		case symbol
//	}
//	
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CurrenciesKey.self)
//		self.code = try values.decode(String.self, forKey: .code)
//		self.name = try values.decode(String.self, forKey: .name)
//		self.symbol = try values.decode(String.self, forKey: .symbol)
//	}
}
