//
//  CountriesListViewModel.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import Foundation

final class CountriesListViewModelImpl: ViewModel {
	
	enum State { }
	
	var stateHandler: ((State) -> Void)?
}
