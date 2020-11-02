//
//  RootViewType.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

protocol RootViewType {
	associatedtype RootViewType: UIView
}

extension RootViewType where Self: UIViewController {
	var rootView: RootViewType {
		guard let rootView = self.view as? RootViewType else {
			fatalError(#function)
		}
		return rootView
	}
}
