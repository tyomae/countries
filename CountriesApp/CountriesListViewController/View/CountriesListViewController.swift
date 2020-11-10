//
//  ViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class CountriesListViewController: BaseViewController<CountriesListViewModelImpl>, UITableViewDataSource, UITableViewDelegate {
	
	var searchController: UISearchController!
	
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
	
	override func setupViewModel() {
		self.viewModel = CountriesListViewModelImpl()
	}
	
	override func processViewModel(state: CountriesListViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.tableView.reloadData()
				self.setupSearchBar()
		}
	}
	
	override var hidesKeyboardAfterTapOnRootView: Bool {
		true
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.sections[section].cellViewModels.count
	}
	
	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return viewModel.sections.map{ $0.title }
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return viewModel.sections[section].title
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell: CountryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let cellViewModel = viewModel.sections[indexPath.section].cellViewModels[indexPath.row]
		cell.configure(with: cellViewModel as! CountryCellViewModel)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		guard let currentCountry = self.viewModel.getCountrybyIndexPath(indexPath: indexPath) else { return }
		self.openCountryVC(with: currentCountry)
	}
	
	private func setupSearchBar() {
		let countriesResultsVC = CountriesResultsViewController()
		let viewModel = CountriesResultsViewModelImpl(countries: self.viewModel.countries)
		countriesResultsVC.viewModel = viewModel
		countriesResultsVC.selectedCountry = { [weak self] country in
			self?.openCountryVC(with: country)
		}
		searchController = UISearchController(searchResultsController: countriesResultsVC)
		searchController.searchResultsUpdater = countriesResultsVC
		searchController.searchBar.placeholder = "Search countries"
		searchController.obscuresBackgroundDuringPresentation = false
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	private func openCountryVC(with country: Country) {
		let vc = CountryViewController()
		let viewModel = CountryViewModelImpl(country: country)
		vc.viewModel = viewModel
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
