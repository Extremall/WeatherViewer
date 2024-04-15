//
//  LocationViewModel.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation

final class LocationViewModel: ObservableObject {
	let location: Location
	let periods: [Period]
	var forecast: GetForecastResponse?
	var weatherService: WeatherServiceProtocol
	
	init(location: Location, periods: [Period]) {
		self.location = location
		self.periods = periods
		weatherService = WeatherService()
	}
}
