//
//  LocationListViewModel.swift
//  WeatherViewer
//
//  Created by Extremall on 14/04/2024.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class LocationListViewModel: ObservableObject {
	func update() {
		NotificationCenter.default.post(name: .reloadData, object: nil)
	}
}

extension Notification.Name {
	static let reloadData = NSNotification.Name("reloadData")
}
