//
//  GetPointsResponse.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation

struct GetPointsResponse: Decodable {
	let properties: GetPointsPropertiesResponse
}

struct GetPointsPropertiesResponse: Decodable {
	let gridId: String
	let gridX: Int16
	let gridY: Int16
	let relativeLocation: RelativeLocation
}

struct RelativeLocation: Decodable {
	let properties: LocationProperties
}

struct LocationProperties: Decodable {
	let city: String
	let state: String
}
