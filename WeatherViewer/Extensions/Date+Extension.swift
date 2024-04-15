//
//  Date+Extension.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation

extension Date {
	var yearMonthDay: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.string(from: self)
	}
	
	var yearMonthDayTime: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
		return dateFormatter.string(from: self)
	}
}
