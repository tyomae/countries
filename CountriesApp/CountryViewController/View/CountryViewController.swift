//
//  CountryViewController.swift
//  CountriesApp
//
//  Created by Артем Емельянов  on 05.11.2020.
//

//TODO: change star icon

import UIKit

class CountryViewController: BaseViewController<CountryViewModelImpl>, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var favouriteCountryButton: UIButton!
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.registerNibs(for: [CountryInfoTableViewCell.self, MapTableViewCell.self])
		}
	}

	
	@IBOutlet weak var flagEmojiLabel: UILabel! {
		didSet {
			flagEmojiLabel.text = TextUtilities.emojiFlag(from: viewModel.country.countryCode)
		}
	}
	@IBOutlet weak var countryNameLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.countryNameLabel.text = viewModel.country.name
		self.isCountryFavourite()
	}
	
	override func processViewModel(state: CountryViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.tableView.reloadData()
			case .isFavouriteUpdated:
				self.isCountryFavourite()
		}
	}
	
	@IBAction func addFavoutireCountryButtonPressed(_ sender: UIButton) {
		viewModel.process(action: .changeFavourite)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.sections[section].cellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return viewModel.sections[section].title
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellViewModel = viewModel.sections[indexPath.section].cellViewModels[indexPath.row]
		if let cellModel = cellViewModel as? BaseCountryInfoCellViewModel {
			let cell: CountryInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		} else if let cellModel = cellViewModel as? MapCellViewModel {
			let cell: MapTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
			cell.configure(with: cellModel)
			return cell
		}
		fatalError("Unknowned cellViewModel")
	}
	
	private func isCountryFavourite() {
		if viewModel.isFavourite == true {
			self.favouriteCountryButton.setImage(#imageLiteral(resourceName: "starPressed"), for: .normal)
		} else if viewModel.isFavourite == false {
			self.favouriteCountryButton.setImage(#imageLiteral(resourceName: "starUnpressed"), for: .normal)
		}
	}
}

