//
//  Reusable.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

protocol Reusable {
	static var reuseId: String { get }
}

extension Reusable {
	static var reuseId: String {
		String(describing: self)
	}
}

extension UIView: Reusable {}
