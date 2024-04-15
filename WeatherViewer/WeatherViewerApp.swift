//
//  WeatherViewerApp.swift
//  WeatherViewer
//
//  Created by Extremall on 12/04/2024.
//

import SwiftUI
import GooglePlaces

@main
struct WeatherViewerApp: App {
    let persistenceController = PersistenceController.shared

	init() {
		// Here should be added API Key for Google Places
		GMSPlacesClient.provideAPIKey("key")
	}
	
    var body: some Scene {
        WindowGroup {
			LocationListView(vm: LocationListViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
				.environment(\.colorScheme, .light)
		}
    }
}
