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

	var managableScrollView: UIScrollView? {
		nil
	}

	var hidesKeyboardAfterTapOnRootView: Bool {
		false
	}

	private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
	private let selectionFeedbackGenerator = UISelectionFeedbackGenerator()

	override func viewDidLoad() {
		self.setupViewModel()
		self.bindViewModelStateHandler()
		super.viewDidLoad()

		self.setupKeyboardObservers()
		if self.hidesKeyboardAfterTapOnRootView {
			self.setupResignTap()
		}
		self.hideNavigationBarSeparator()
	}

	// MARK: - Public API
	
	func setupViewModel() { }
	
	func processViewModel(state: ViewModelType.State) { }

	// MARK: - Keyboard resize events

	// Called before system keyboard will change its Size on show/hide event.
	func keyboardWillChangeSize(with info: KeyboardNotification) {
		UIView.animate(withDuration: 0.2) { [weak self] in
			// adding toolbar height(44) and offset(16)
			self?.managableScrollView?.contentInset.bottom = info.offset > 0 ? info.offset + 44 + 16 : 0
		}
	}

	// Called after system keyboard changed its Size on show/hide event.
	func keyboardDidChangeSize(with info: KeyboardNotification) {}

	// MARK: - Haptic logic

	func hapticSelection() {
		self.selectionFeedbackGenerator.prepare()
		self.selectionFeedbackGenerator.selectionChanged()
	}

	// MARK: - Private logic
	
	private func bindViewModelStateHandler() {
		self.viewModel.stateHandler = { [weak self] state in
			self?.processViewModel(state: state)
		}
	}

	@objc
	private func hideKeyboard() {
		self.view.endEditing(true)
	}

	private func setupResignTap() {
		let resignTap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
		resignTap.numberOfTapsRequired = 1
		resignTap.cancelsTouchesInView = false
		self.view.addGestureRecognizer(resignTap)
	}

	// MARK: - Keyboard observers
	private func setupKeyboardObservers() {
		let notificationCenter = NotificationCenter.default

		[
			UIResponder.keyboardWillShowNotification,
			UIResponder.keyboardWillHideNotification,
			UIResponder.keyboardWillChangeFrameNotification
		].forEach {
			notificationCenter.addObserver(
				self,
				selector: #selector(self.keyboardWillShowHideChangeFrame),
				name: $0,
				object: nil
			)
		}

		[
			UIResponder.keyboardDidShowNotification,
			UIResponder.keyboardDidHideNotification,
			UIResponder.keyboardDidChangeFrameNotification
		].forEach {
			notificationCenter.addObserver(
				self,
				selector: #selector(self.keyboardDidShowHideChangeFrame),
				name: $0,
				object: nil
			)
		}
	}

	@objc
	private func keyboardWillShowHideChangeFrame(_ notification: Notification) {
		guard let keyboardNotification = KeyboardNotification(notification) else {
			assertionFailure("Unable to parse user info from keyboard notification")
			return
		}
		self.keyboardWillChangeSize(with: keyboardNotification)
	}

	@objc
	private func keyboardDidShowHideChangeFrame(_ notification: Notification) {
		guard let keyboardNotification = KeyboardNotification(notification) else {
			assertionFailure("Unable to parse user info from keyboard notification")
			return
		}
		self.keyboardDidChangeSize(with: keyboardNotification)
	}
	
	private func hideNavigationBarSeparator() {
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
	}
}
