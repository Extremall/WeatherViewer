//
//  Location.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation

final class Location: Observable {
	let city: String
	let state: String
	let gridId: String
	let gridX: Int16
	let gridY: Int16
	@Published var lastUpdated: Date?
	
	init(city: String, state: String, gridId: String, gridX: Int16, gridY: Int16, lastUpdated: Date?) {
		self.city = city
		self.state = state
		self.gridId = gridId
		self.gridX = gridX
		self.gridY = gridY
		self.lastUpdated = lastUpdated
	}
	
	convenience init(coreDataObject: CoreDataLocation) {
		self.init(city: coreDataObject.city,
				  state: coreDataObject.state,
				  gridId: coreDataObject.gridId,
				  gridX: coreDataObject.gridX,
				  gridY: coreDataObject.gridY,
				  lastUpdated: coreDataObject.lastUpdated)
	}
}
