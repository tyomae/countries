//
//  NumberFormatter+Static.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 07.11.2020.
//

import Foundation

extension NumberFormatter {
	static var common: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 0
		return formatter
	}()
}
