//
//  GetForecastResponse.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation

struct GetForecastResponse: Decodable {
	let properties: GetForecastPropertiesResponse
}

struct GetForecastPropertiesResponse: Decodable {
	let periods: [ForecastPeriod]
}

struct ForecastPeriod: Decodable {
	let number: Int16
	let name: String
	let startTime: String
	let endTime: String
	let isDaytime: Bool
	let temperature: Int16
	let temperatureUnit: String
	let relativeHumidity: RelativeHumidity
	let windSpeed: String
	let windDirection: String
	let icon: String
	let shortForecast: String
	let detailedForecast: String
	
	var startTimeDate: Date {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
		dateFormatter.timeZone = TimeZone.current
		return dateFormatter.date(from: startTime)!
	}
	
	var endTimeDate: Date {
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
		dateFormatter.timeZone = TimeZone.current
		return dateFormatter.date(from: endTime)!
	}
}

struct RelativeHumidity: Decodable {
	let value: Int16
}
