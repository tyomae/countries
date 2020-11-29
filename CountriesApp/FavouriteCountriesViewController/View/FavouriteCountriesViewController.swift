//
//  FavouriteCountriesViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import UIKit

class FavouriteCountriesViewController: BaseViewController<FavouriteCountriesViewModel>, UITableViewDataSource, UITableViewDelegate {
	
	var selectedCountry: ((CountryEntity) -> ())?
	
	@IBOutlet weak var emptyListLabel: UILabel!
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.registerNib(for: CountryTableViewCell.self)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource =  self
		
	}
	
	override func setupViewModel() {
		self.viewModel = FavouriteCountriesViewModel()
	}
	
	override func processViewModel(state: FavouriteCountriesViewModel.State) {
		switch state {
			case .dataUpdated:
				UIView.animate(withDuration: 0.8) {
					self.tableView.reloadData()
				}
			case .emptyList:
				self.emptyListLabel.isHidden = !viewModel.favouritesCountries.isEmpty
				self.tableView.isHidden = viewModel.favouritesCountries.isEmpty
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.favouritesCountries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: CountryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let cellViewModel = viewModel.cellViewModels[indexPath.row]
		cell.configure(with: cellViewModel)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		openCountryVC(with: self.viewModel.favouritesCountries[indexPath.row])
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let country = self.viewModel.favouritesCountries[indexPath.row]
		
		let contextItem = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
			self.viewModel.process(action: .deleteCountry(countryCode: country.countryCode))
			self.viewModel.favouritesCountries.remove(at: indexPath.row)
			self.tableView.deleteRows(at: [indexPath], with: .automatic)
		}
		let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

		return swipeActions
	}
	
	private func openCountryVC(with country: CountryEntity) {
		let vc = CountryViewController()
		let isFavourite = viewModel.favouriteCountryService.isFavouriteCountry(countryCode: country.countryCode)
		let viewModel = CountryViewModelImpl(country: country, isFavourite: isFavourite)
		vc.viewModel = viewModel
		vc.hidesBottomBarWhenPushed =  true
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
