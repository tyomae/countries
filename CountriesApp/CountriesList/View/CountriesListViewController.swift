//
//  ViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class CountriesListViewController: BaseViewController<CountriesListViewModelImpl>, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.registerNib(for: CountryTableViewCell.self)
		}
	}
	
	var searchController: UISearchController!
	private var countries = [Country]()
	private var hotelService = CountryServiceImpl()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupSearchBar()
		self.getCountries()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self
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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: CountryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		
		let country = countries[indexPath.row]
		let countryCell = CountryViewModelImpl(countryName: country.name, regionName: country.region, emojiFlag: "🇷🇺")
		cell.configure(with: countryCell)
		return cell
	}
	
	private func getCountries() {
		hotelService.getCountries {
			switch $0{
			case let .success(countries):
				self.countries.removeAll()
				self.countries = countries
				self.tableView.reloadData()
			case let .failure(error):
				self.countries.removeAll()
				self.tableView.reloadData()
				print(error)
			}
		}
	}
}

