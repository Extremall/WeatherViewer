//
//  Period.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation

final class Period {
	let number: Int16
	let name: String
	let startTime: Date
	let endTime: Date
	let isDaytime: Bool
	let temperature: Int16
	let temperatureUnit: String
	let relativeHumidity: Int16
	let windSpeed: String
	let windDirection: String
	let icon: String
	let shortForecast: String
	let detailedForecast: String
	
	init(number: Int16, name: String, startTime: Date, endTime: Date, isDaytime: Bool, temperature: Int16, temperatureUnit: String, relativeHumidity: Int16, windSpeed: String, windDirection: String, icon: String, shortForecast: String, detailedForecast: String) {
		self.number = number
		self.name = name
		self.startTime = startTime
		self.endTime = endTime
		self.isDaytime = isDaytime
		self.temperature = temperature
		self.temperatureUnit = temperatureUnit
		self.relativeHumidity = relativeHumidity
		self.windSpeed = windSpeed
		self.windDirection = windDirection
		self.icon = icon
		self.shortForecast = shortForecast
		self.detailedForecast = detailedForecast
	}
	
	convenience init(coreDataObject: CoreDataPeriod) {
		self.init(number: coreDataObject.number,
				  name: coreDataObject.name,
				  startTime: coreDataObject.startTime,
				  endTime: coreDataObject.endTime,
				  isDaytime: coreDataObject.isDaytime,
				  temperature: coreDataObject.temperature,
				  temperatureUnit: coreDataObject.temperatureUnit,
				  relativeHumidity: coreDataObject.relativeHumidity,
				  windSpeed: coreDataObject.windSpeed,
				  windDirection: coreDataObject.windDirection,
				  icon: coreDataObject.icon,
				  shortForecast: coreDataObject.shortForecast,
				  detailedForecast: coreDataObject.detailedForecast)
	}
	
	convenience init(forecastPeriod: ForecastPeriod) {
		self.init(number: forecastPeriod.number,
				  name: forecastPeriod.name,
				  startTime: forecastPeriod.startTimeDate,
				  endTime: forecastPeriod.endTimeDate,
				  isDaytime: forecastPeriod.isDaytime,
				  temperature: forecastPeriod.temperature,
				  temperatureUnit: forecastPeriod.temperatureUnit,
				  relativeHumidity: forecastPeriod.relativeHumidity.value,
				  windSpeed: forecastPeriod.windSpeed,
				  windDirection: forecastPeriod.windDirection,
				  icon: forecastPeriod.icon,
				  shortForecast: forecastPeriod.shortForecast,
				  detailedForecast: forecastPeriod.detailedForecast)
	}
}

extension Period: Identifiable {
	public var id: Int16 {
		return number
	}
}
