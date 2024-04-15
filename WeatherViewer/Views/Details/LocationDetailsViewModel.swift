//
//  LocationDetailsViewModel.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation

class LocationDetailsViewModel: ObservableObject {
	let period: Period
	
	init(period: Period) {
		self.period = period
	}
}
