//
//  ViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class CountriesListViewController: BaseViewController<CountriesListViewModelImpl> {
	
	var searchController: UISearchController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupSearchBar()
	}
	
	 override func setupViewModel() {
		self.viewModel = CountriesListViewModelImpl()
	}
	
	override var hidesKeyboardAfterTapOnRootView: Bool {
		true
	}
	
	private func setupSearchBar() {
		searchController = UISearchController(searchResultsController: nil)
		searchController.searchBar.placeholder = "Search countries"
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.searchController = searchController
	}
}

