//
//  RealmController.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 11.11.2020.
//

import Foundation
import RealmSwift

var mainRealm: Realm!

class RealmController {
	static var shared = RealmController()

	let schemaVersion: UInt64 = 0

	func setup() {
		Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: nil)

		do {
			mainRealm = try Realm()
		} catch let error as NSError {
			NotificationCenter.default.post(name: .RealmLoadingErrorNotifications, object: nil)
			assertionFailure("Realm loading error: \(error)")
		}
	}
}
