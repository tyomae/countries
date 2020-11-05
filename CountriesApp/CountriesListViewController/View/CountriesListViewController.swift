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
		}
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
	}
}
