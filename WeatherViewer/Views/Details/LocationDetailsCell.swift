//
//  LocationDetailsCell.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct LocationDetailsCell: View {
	@ObservedObject var vm: LocationDetailsViewModel
	var body: some View {
		VStack {
			Text(vm.period.startTime.yearMonthDay)
				.font(.largeTitle)
			Text(vm.period.isDaytime ? "Day" : "Night")
			HStack {
				Text("\(vm.period.temperature)°\(vm.period.temperatureUnit)")
					.font(.title2)
				Spacer()
				if let url = URL(string: vm.period.icon) {
					KFImage(url)
				}
			}
			HStack {
				Text("Humidity: \(vm.period.relativeHumidity)%")
					.font(.title3)
					.padding(.top, 10)
				Spacer()
			}
			HStack {
				Text("Wind speed: \(vm.period.windSpeed)")
					.font(.title3)
					.padding(.vertical, 10)
				Spacer()
			}
			Text("\(vm.period.detailedForecast)")
				.font(.footnote)
		}
	}
}
