//
//  FavouriteCountriesViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation

final class FavouriteCountriesViewModel: ViewModel {
		
	var stateHandler: ((State) -> Void)?
	var cellViewModels = [CountryCellViewModel]()
	private var countries = [Country]()
	
	enum State {
		case dataUpdated
	}
	
	init() {

	}
}
