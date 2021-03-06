//
//  FavouriteCountryService.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 13.11.2020.
//

import UIKit
import RealmSwift

protocol FavouriteCountryService {
	func addCountryToFavourite(countryCode: String)
	func removeFavouriteCountry(countryCode: String)
	func getFavouriteCountries() -> [CountryEntity]
	func isFavouriteCountry(countryCode: String) -> Bool
	func addListener(handler: @escaping (() -> Void))
}

class FavouriteCountryServiceImpl: FavouriteCountryService {
	
	private var savedCountriesCode = mainRealm.objects(FavouriteCountryEntity.self)
	private var notificationToken: NotificationToken?
	private var _handler: (() -> ())?
	
	func addListener(handler: @escaping (() -> Void)) {
		self._handler = handler
		self.notificationToken = self.savedCountriesCode.observe { [weak self] _ in
			self?._handler?()
		}
	}
	
	deinit {
		self.notificationToken?.invalidate()
	}
	
	func addCountryToFavourite(countryCode: String) {
		let favouriteCountryEntity = FavouriteCountryEntity(countryCode: countryCode)
		realmWrite {
			mainRealm.add(favouriteCountryEntity, update: .all)
		}
	}
	
	func removeFavouriteCountry(countryCode: String) {
		if let currentCountryCode = mainRealm.object(ofType: FavouriteCountryEntity.self, forPrimaryKey: countryCode) {
			realmWrite {
				mainRealm.delete(currentCountryCode)
			}
		}
	}
	
	func getFavouriteCountries() -> [CountryEntity] {
		var favouritesCountries = [CountryEntity]()
		let sortedCountriesCode = Array(self.savedCountriesCode).sorted { (savedCode1, savedCode2) -> Bool in
			return savedCode1.addingDate < savedCode2.addingDate
		}
		for countryCode in sortedCountriesCode {
			if let countryByCode = mainRealm.object(ofType: CountryEntity.self, forPrimaryKey: countryCode.countryId) {
				favouritesCountries.append(countryByCode)
			}
		}
		return favouritesCountries
	}
	
	func isFavouriteCountry(countryCode: String) -> Bool {
		return self.savedCountriesCode.contains {
			return $0.countryId == countryCode
		}
	}
}
