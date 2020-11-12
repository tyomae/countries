//
//  FavouriteCountriesViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import UIKit

class FavouriteCountriesViewController: BaseViewController<FavouriteCountriesViewModel>, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.registerNib(for: CountryInfoTableViewCell.self)
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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
