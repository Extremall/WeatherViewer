//
//  CoreDataLocation.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import CoreData

final class CoreDataLocation: NSManagedObject {
	@NSManaged var state: String
	@NSManaged var city: String
	@NSManaged var gridId: String
	@NSManaged var lastUpdated: Date?
	@NSManaged var gridX: Int16
	@NSManaged var gridY: Int16
	
	@NSManaged public var periods: Set<CoreDataPeriod>
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataLocation> {
		return NSFetchRequest<CoreDataLocation>(entityName: "\(Self.self)")
	}
	
	func addToPeriods(_ period: CoreDataPeriod) {
		self.mutableSetValue(forKey: "periods").add(period)
	}
	
	func setPeriods(context: NSManagedObjectContext, periods: [ForecastPeriod]) {
		self.periods.removeAll()
		for period in periods {
			let coreDataPeriod = CoreDataPeriod(context: context, period: period)
			self.addToPeriods(coreDataPeriod)
		}
		self.lastUpdated = Date()
		do {
			try context.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}
	
	static func getLocation(gridId: String, context: NSManagedObjectContext) -> CoreDataLocation? {
		let request: NSFetchRequest<CoreDataLocation> = CoreDataLocation.fetchRequest()
		request.predicate = NSPredicate(format: "gridId == %@", gridId)
		
		var coreDataLocation: CoreDataLocation?
		do {
			let results = try context.fetch(request)
			coreDataLocation = results.first
		} catch let error {
			print("Query error: \(error)")
			return nil
		}
		
		return coreDataLocation
	}
	
	static func isLocationExists(gridId: String, context: NSManagedObjectContext) -> Bool {
		return getLocation(gridId: gridId, context: context) != nil
	}
}

extension CoreDataLocation: Identifiable {
	public var id: String {
		return gridId
	}
}
