//
//  UITableView+registerCell.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

import UIKit

extension UITableView {
	
	func registerNib<T: UITableViewCell>(for cellClass: T.Type) {
		register(T.nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}
	
	func registerNibs(for cellClasses: [UITableViewCell.Type]) {
		cellClasses.forEach { register($0.nib, forCellReuseIdentifier: $0.defaultReuseIdentifier) }
	}
	
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}
		return cell
	}
}

protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

protocol NibLoadableView: class {
	static var nib: UINib { get }
}

extension ReusableView where Self: UIView {
	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}
extension NibLoadableView where Self: UIView {
	static var nib: UINib {
		let nibName = String(describing: self)
		return UINib(nibName: nibName, bundle: nil)
	}
}

extension UITableViewCell: ReusableView, NibLoadableView {
	
}
