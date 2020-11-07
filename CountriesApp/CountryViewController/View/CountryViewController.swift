//
//  CountryViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 05.11.2020.
//

import UIKit

class CountryViewController: BaseViewController<CountryViewModelImpl>, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.registerNib(for: CountryInfoTableViewCell.self)
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
	}
	
	override func processViewModel(state: CountryViewModelImpl.State) {
		switch state {
			case .dataLoaded:
				self.tableView.reloadData()
		}
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
		
		let cell: CountryInfoTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
		let cellViewModel = viewModel.sections[indexPath.section].cellViewModels[indexPath.row]
		cell.configure(with: cellViewModel as! BaseCountryInfoCellViewModel)
		return cell
	}
}

