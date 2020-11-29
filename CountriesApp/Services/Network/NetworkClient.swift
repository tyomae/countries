//
//  NetworkClient.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 03.11.2020.
//

enum APIError: Error {
	case internalError
	case serverError
	case noInternet
	
	var stringError: String {
		switch self {
		case.serverError:
			return "Server error 😳"
		case.noInternet:
			return "No network access 😩"
		case.internalError:
			return "No network access 😩"
		}
	}
}
