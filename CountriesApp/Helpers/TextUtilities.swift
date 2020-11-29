//
//  TextUtilities.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

import Foundation

struct TextUtilities {
	 static func emojiFlag(from code: String) -> String {
		let base : UInt32 = 127397
		var string = ""
		for emojiCode in code.unicodeScalars {
			string.unicodeScalars.append(UnicodeScalar(base + emojiCode.value)!)
		}
		return String(string)
	}
}
