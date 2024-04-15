//
//  FindLocationViewModel.swift
//  WeatherViewer
//
//  Created by Extremall on 14/04/2024.
//

import Foundation
import GooglePlaces
import CoreData
import SwiftUI

final class FindLocationViewModel: ObservableObject {
	let service: WeatherServiceProtocol = WeatherService()
	let context: NSManagedObjectContext
	
	@Published var places: [Place] = []
	
	var showModal: Binding<Bool>
	
	
	private var placesClient: GMSPlacesClient!
	let token = GMSAutocompleteSessionToken.init()
	let filter = GMSAutocompleteFilter()
	
	init(context: NSManagedObjectContext, showModal: Binding<Bool>) {
		self.context = context
		self.showModal = showModal
		
		placesClient = GMSPlacesClient.shared()
		filter.types = ["locality"]
		filter.countries = ["US"]
	}
	
	func findLocation(query: String) {
		fetchAddresses(with: query)
	}
	
	func fetchAddresses(with query: String) {
		placesClient?.findAutocompletePredictions(fromQuery: query,
												  filter: filter,
												  sessionToken: token,
												  callback: { [weak self] (results, error) in
			guard let self = self else { return }
			
			if let _ = error {
				self.places = []
				return
			}
			if let results = results {
				self.places = results.map({ Place(address: $0.attributedFullText.string, placeID: $0.placeID) })
			} else {
				self.places = []
			}
		})
	}
	
	func fetchInfo(placeID: String) {
		// Didn't finish, because can't get an API Key
		// but here we just use
	}
	
	func getInfo(placeID: String, completion: @escaping (PlaceDetails) -> Void) {
		placesClient.lookUpPlaceID(placeID) { place, error in
			if let coordinate = place?.coordinate {
				// save coordinates
			}
		}
	}
}

struct PlaceDetails {
	var state: String
	var city: String
}

struct Place: Identifiable {
	var address: String
	var placeID: String
	var id: String {
		return placeID
	}
}
