//
//  BaseViewController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

class BaseViewController<V: ViewModel>: UIViewController {
	typealias ViewModelType = V
	
	var viewModel: ViewModelType!

	override func viewDidLoad() {
		self.setupViewModel()
		self.bindViewModelStateHandler()
		super.viewDidLoad()

		self.hideNavigationBarSeparator()
	}

	// MARK: - Public API
	
	func setupViewModel() { }
	
	func processViewModel(state: ViewModelType.State) { }
	
	// MARK: - Private logic
	
	private func bindViewModelStateHandler() {
		self.viewModel.stateHandler = { [weak self] state in
			self?.processViewModel(state: state)
		}
	}
	
	private func hideNavigationBarSeparator() {
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
	}
}
