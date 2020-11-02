//
//  BaseTableViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class BaseTableViewController<ViewModelType: TableViewSectionsViewModel, RootViewClass: BaseRootTableView>: BaseViewController<RootViewClass, ViewModelType>, UITableViewDelegate, UITableViewDataSource {
	
	var alwaysRemoveTopOffset = false

	override var managableScrollView: UIScrollView? {
		self.rootView.tableView
	}
	
	override var hidesKeyboardAfterTapOnRootView: Bool {
		true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		assert(self.viewModel != nil, "You must set `viewModel` property in order to use BaseTableViewController")
		self.rootView.tableView.willReload = { [weak self] in
			if let viewModel = self?.viewModel {
				self?.rootView.tableView.register(sectionsViewModel: viewModel)
			}
		}
		self.rootView.tableView.delegate = self
		self.rootView.tableView.dataSource = self
	}

	// MARK: - UITableViewDelegate, UITableViewDataSource
	func numberOfSections(in tableView: UITableView) -> Int {
		// If first section has title then we need to set tiny header to remove extra top offset, otherwise it must be nil so tableView has natural top offset
		if self.viewModel.sections.first?.title != nil || self.alwaysRemoveTopOffset {
			tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
		} else {
			tableView.tableHeaderView = nil
		}

		return self.viewModel.sections.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.viewModel.sections[section].cells.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		self.viewModel.sections[section].title
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		self.viewModel.sections[indexPath.section].cells[indexPath.row].action?()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let object = self.viewModel.sections[indexPath.section].cells[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: object.dataType.reuseId, for: indexPath) as! BaseConfigurableTableViewCell
		cell.configure(with: object.dataType)
		return cell
	}
}
