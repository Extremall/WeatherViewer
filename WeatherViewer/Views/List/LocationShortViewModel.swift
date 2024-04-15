//
//  LocationShortViewModel.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import CoreData
import SwiftUI

final class LocationShortViewModel: ObservableObject {
	var weatherService: WeatherServiceProtocol
	@Published var location: Location
	let context: NSManagedObjectContext
	@Published var periods: [Period]
	
	@Published var isLoading: Bool = false
	@Published var isUpToDate: Bool = true
	@Published var lastUpdated: Date?

	init(location: Location, periods: [Period], context: NSManagedObjectContext) {
		self.location = location
		self.periods = periods
		self.context = context
		weatherService = WeatherService()
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleReloadData(_:)), name: .reloadData, object: nil)
	}
	
	@objc func handleReloadData(_ notification: Notification) {
		loadForecast()
	}
	
	func softUpdate() {
		if let lastUpdated = location.lastUpdated, (-lastUpdated.timeIntervalSinceNow) < Constants.intervalForUpdatePeriods {
			isUpToDate = true
		} else {
			isUpToDate = false
			lastUpdated = location.lastUpdated
			loadForecast()
		}
	}
	
	func loadForecast() {
		isLoading = true
		weatherService.getForecast(request:
									GetForecastRequest(gridId: location.gridId,
													   gridX: location.gridX,
													   gridY: location.gridY)) { [weak self] result in
			guard let self else { return }
			
			self.isLoading = false
			switch result {
				case .success(let response):
					DispatchQueue.main.async {
						CoreDataPeriod.setNewPeriods(context: self.context,
													 periods: response.properties.periods,
													 to: self.location)
						self.periods = response.properties.periods.map({ Period(forecastPeriod: $0) })
						self.location.lastUpdated = Date()
						self.isUpToDate = true
					}
				case .failure(let error):
					print("error = \(error)")
			}
		}
	}
}
