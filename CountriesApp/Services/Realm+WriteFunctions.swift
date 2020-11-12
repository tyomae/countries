//
//  Realm+WriteFunctions.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation
import RealmSwift

extension Realm {
	func realmWrite(_ block: (() -> Void)) {
		if isInWriteTransaction {
			block()
		} else {
			do {
				try write(block)
			} catch {
				NotificationCenter.default.post(
					name: .RealmWritingErrorNotifications,
					object: nil
				)
				assertionFailure("Realm write error: \(error)")
			}
		}
	}
}

func realmWrite(realm: Realm = mainRealm, _ block: (() -> Void)) {
	realm.realmWrite(block)
}
