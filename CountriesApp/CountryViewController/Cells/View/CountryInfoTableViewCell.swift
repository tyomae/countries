//
//  CountryInfoTableViewCell.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 05.11.2020.
//

import UIKit

class CountryInfoTableViewCell: UITableViewCell, ConfigurableView {

	@IBOutlet weak var propertyLabel: UILabel!
	@IBOutlet weak var valueLabel: UILabel!
	
	func configure(with model: BaseCountryInfoCellViewModel) {
		self.propertyLabel.text = model.property
		self.valueLabel.text = model.value
	}
}
