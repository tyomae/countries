//
//  CountriesResultsViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 10.11.2020.
//

import UIKit

class CountriesResultsViewController: BaseViewController<CountriesResultsViewModelImpl>, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
	
	var selectedCountry: ((CountryEntity) -> ())?
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.registerNib(for: CountryTableViewCell.self)
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.dataSource = self
		self.tableView.delegate = self
    }
	
	override func processViewModel(state: CountriesResultsViewModelImpl.State) {
		switch state {
			case .dataUpdated:
				self.tableView.reloadData()
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.filteredCountries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: CountryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let cellViewModel = viewModel.cellViewModels[indexPath.row]
		cell.configure(with: cellViewModel)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		selectedCountry?(viewModel.filteredCountries[indexPath.row])
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		viewModel.process(action: .searchTextDidChanged(text: searchController.searchBar.text ?? ""))
	}
}
