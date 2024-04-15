//
//  CoreDataPeriod.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import CoreData

final class CoreDataPeriod: NSManagedObject {
	@NSManaged var windSpeed: String
	@NSManaged var windDirection: String
	@NSManaged var temperatureUnit: String
	@NSManaged var temperature: Int16
	@NSManaged var startTime: Date
	@NSManaged var endTime: Date
	@NSManaged var shortForecast: String
	@NSManaged var detailedForecast: String
	@NSManaged var relativeHumidity: Int16
	@NSManaged var number: Int16
	@NSManaged var name: String
	@NSManaged var icon: String
	@NSManaged var isDaytime: Bool
	
	@NSManaged public var location: CoreDataLocation?
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataPeriod> {
		return NSFetchRequest<CoreDataPeriod>(entityName: "CoreDataPeriod")
	}
}

extension CoreDataPeriod {
	convenience init(context: NSManagedObjectContext, period: ForecastPeriod) {
		self.init(context: context)
		self.windSpeed = period.windSpeed
		self.windDirection = period.windDirection
		self.temperatureUnit = period.temperatureUnit
		self.temperature = period.temperature
		self.startTime = period.startTimeDate
		self.endTime = period.endTimeDate
		self.shortForecast = period.shortForecast
		self.detailedForecast = period.detailedForecast
		self.relativeHumidity = period.relativeHumidity.value
		self.number = period.number
		self.name = period.name
		self.icon = period.icon
		self.isDaytime = period.isDaytime
	}
	
	static func setNewPeriods(context: NSManagedObjectContext, periods: [ForecastPeriod], to location: Location) {
		guard let coreDataLocation = CoreDataLocation.getLocation(gridId: location.gridId, context: context) else { return }
		
		coreDataLocation.setPeriods(context: context, periods: periods)
	}
	
	static func createPeriod(context: NSManagedObjectContext, period: ForecastPeriod, location: Location) {
		guard let coreDataLocation = CoreDataLocation.getLocation(gridId: location.gridId, context: context) else { return }
		
		let period = CoreDataPeriod(context: context, period: period)
		coreDataLocation.addToPeriods(period)
		do {
			try context.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}
}
