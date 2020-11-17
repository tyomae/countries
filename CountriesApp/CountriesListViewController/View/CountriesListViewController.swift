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
			tableView.sectionIndexColor = UIColor.systemIndigo
		}
	}
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var retryButton: UIButton! {
		didSet {
			retryButton.setTitle("Retry", for: .normal)
			retryButton.setTitleColor(.systemIndigo, for: .normal)
			retryButton.layer.cornerRadius = 8
			retryButton.layer.borderWidth = 1
			retryButton.layer.borderColor = UIColor.systemIndigo.cgColor
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.dataSource = self
		self.tableView.delegate = self
		
		self.setupSearchBar()
	}
	
	override func setupViewModel() {
		self.viewModel = CountriesListViewModelImpl()
	}
	
	override func processViewModel(state: CountriesListViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.setupSearchBar()
				self.activityIndicator.stopAnimating()
				self.activityIndicator.isHidden = true
				self.retryButton.isHidden = true
				self.errorLabel.isHidden = true
				self.tableView.isHidden = false
				self.tableView.reloadData()
			case .loading:
				self.activityIndicator.startAnimating()
				self.activityIndicator.isHidden = false
				self.errorLabel.text = "Loading countries..."
				self.retryButton.isHidden = true
				self.tableView.isHidden = true
			case .error(let error):
				self.activityIndicator.stopAnimating()
				self.activityIndicator.isHidden = true
				self.retryButton.isHidden = false
				self.errorLabel.text = error
				self.tableView.isHidden = true
		}
	}
	
	@IBAction func retryButtonToched(_ sender: Any) {
		self.viewModel.getCountries()
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
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		if let currentCountry = self.viewModel.getCountrybyIndexPath(indexPath: indexPath) {
			let contextItem: UIContextualAction
			if self.viewModel.favouritesCountryService.isFavouriteCountry(countryCode: currentCountry.countryCode) ==  true {
				contextItem = UIContextualAction(style: .normal, title: "Delete from Favourites") { _,_,_ in
					self.viewModel.process(action: .deleteCountry(countryCode: currentCountry.countryCode))
				}
			} else {
				contextItem = UIContextualAction(style: .normal, title: "Add to Favourites") { _,_,_ in
					self.viewModel.process(action: .addCountry(countryCode: currentCountry.countryCode))
				}
			}
			let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
			return swipeActions
		}
		return UISwipeActionsConfiguration()
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
		searchController.searchBar.tintColor = .systemIndigo
		searchController.obscuresBackgroundDuringPresentation = false
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.searchController = searchController
		
		navigationItem.backBarButtonItem?.tintColor = UIColor.systemIndigo
		
		definesPresentationContext = true
	}
	
	private func openCountryVC(with country: CountryEntity) {
		let vc = CountryViewController()
		let isFavourite = viewModel.favouritesCountryService.isFavouriteCountry(countryCode: country.countryCode)
		let viewModel = CountryViewModelImpl(country: country, isFavourite: isFavourite)
		vc.viewModel = viewModel
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
