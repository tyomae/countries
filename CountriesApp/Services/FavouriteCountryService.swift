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
		_handler = handler
		notificationToken = self.savedCountriesCode.observe { [weak self] _ in
			self?._handler?()
		}
	}
	
	deinit {
		notificationToken?.invalidate()
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
		for countryCode in Array(savedCountriesCode) {
			if let countryByCode = mainRealm.object(ofType: CountryEntity.self, forPrimaryKey: countryCode.countryId) {
				favouritesCountries.append(countryByCode)
			}
		}
		return favouritesCountries
	}
	
	func isFavouriteCountry(countryCode: String) -> Bool {
		return savedCountriesCode.contains {
			return $0.countryId == countryCode
		}
	}
}
