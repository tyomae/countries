//
//  CountryTableViewCell.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class CountryTableViewCell: UITableViewCell, ConfigurableView {
	@IBOutlet weak var ovalView: UIView! {
		didSet {
			ovalView.layer.cornerRadius = 26
			ovalView.layer.masksToBounds = true
		}
	}
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var regionLabel: UILabel!
	@IBOutlet weak var flagLabel: UILabel!
	
	func configure(with model: CountryViewModel) {
		self.countryNameLabel.text = model.countryName
		self.regionLabel.text = model.regionName
		self.flagLabel.text = model.emojiFlag
	}
}
