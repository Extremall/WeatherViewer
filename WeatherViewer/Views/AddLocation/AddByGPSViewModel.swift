//
//  AddByGPSViewModel.swift
//  WeatherViewer
//
//  Created by Extremall on 14/04/2024.
//

import Foundation
import CoreData
import SwiftUI
import CoreLocation

final class AddByGPSViewModel: NSObject, ObservableObject {
	let service: WeatherServiceProtocol = WeatherService()
	let context: NSManagedObjectContext
	
	@Published var searchResult: GetPointsResponse?
	@Published var failedSearch: Bool = false
	@Published var locationExists: Bool = false
	@Published var latitude: String = ""
	@Published var longitude: String = ""
	
	var showModal: Binding<Bool>
	var locationManager: CLLocationManager?
	
	init(context: NSManagedObjectContext, showModal: Binding<Bool>) {
		self.context = context
		self.showModal = showModal
		super.init()
	}
	
	func find(latitude: Double, longitude: Double) {
		service.getPoints(latitude: latitude, longitude: longitude) { [weak self] result in
			guard let self else { return }
			
			switch result {
				case .success(let response):
					self.searchResult = response
					self.failedSearch = false
					self.locationExists = CoreDataLocation.isLocationExists(gridId: response.properties.gridId, context: context)
				case .failure(let error):
					print("Search error: \(error)")
					self.searchResult = nil
					self.failedSearch = true
			}
		}
	}
	
	func addToList() {
		guard let properties = searchResult?.properties, !CoreDataLocation.isLocationExists(gridId: properties.gridId, context: context) else { return }
		
		let newLocation = CoreDataLocation(context: context)
		newLocation.city = properties.relativeLocation.properties.city
		newLocation.state = properties.relativeLocation.properties.state
		newLocation.gridId = properties.gridId
		newLocation.gridX = properties.gridX
		newLocation.gridY = properties.gridY

		do {
			try context.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
		
		showModal.wrappedValue = false
	}
	
	func getCurrentCoordinate() {
		locationManager = CLLocationManager()
		locationManager!.delegate = self
		switch locationManager!.authorizationStatus {
			case .notDetermined:
				locationManager!.requestWhenInUseAuthorization()
			case .restricted, .denied:
				break
			case .authorizedAlways, .authorizedWhenInUse:
				locationManager!.startUpdatingLocation()
			default:
				break
		}
	}
}

extension AddByGPSViewModel: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager?.startUpdatingLocation()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			latitude = "\(location.coordinate.latitude)"
			longitude = "\(location.coordinate.longitude)"
		}
		locationManager?.stopUpdatingLocation()
		locationManager = nil
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		locationManager?.stopUpdatingLocation()
		locationManager = nil
	}
}
