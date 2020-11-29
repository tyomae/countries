//
//  MapCellViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 08.11.2020.
//

import Foundation

protocol MapCellViewModel {
	var latitude: Double { get }
	var longitude: Double { get }
}

final class MapCellViewModelImpl: MapCellViewModel, CellViewModel {
	let latitude: Double
	let longitude: Double

	init(latitude: Double, longitude: Double) {
		self.latitude = latitude
		self.longitude = longitude
	}
}
