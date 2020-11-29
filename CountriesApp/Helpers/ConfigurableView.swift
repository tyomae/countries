//
//  ConfigurableView.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import Foundation

protocol ConfigurableView {
	
	associatedtype ConfigurationModel
	
	func configure(with model: ConfigurationModel)
}
