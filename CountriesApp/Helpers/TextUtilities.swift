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
		var s = ""
		for v in code.unicodeScalars {
			s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
		}
		return String(s)
	}
}
