//
//  KeyboardNotification.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 02.11.2020.
//

import UIKit

struct KeyboardNotification {
	let beginFrame: CGRect
	let endFrame: CGRect
	var offset: CGFloat {
		UIScreen.main.bounds.height - self.endFrame.minY
	}

	init?(_ notification: Notification) {
		guard let info = notification.userInfo else {
			return nil
		}
		let beginFrame = info[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
		let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect

		self.beginFrame = beginFrame ?? CGRect.zero
		self.endFrame = endFrame ?? CGRect.zero
	}
}
