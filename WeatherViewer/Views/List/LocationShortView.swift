//
//  LocationShortView.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct LocationShortView: View {
	@ObservedObject var vm: LocationShortViewModel
	
	var body: some View {
		VStack {
			Text("\(vm.location.city)")
				.font(.title)
			HStack {
				if vm.isLoading {
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle())
				} else {
					if vm.periods.isEmpty {
						Text("Can't load data")
					} else {
						VStack {
							let period = vm.periods.first!
							HStack {
								Text("\(period.temperature)°\(period.temperatureUnit)")
								Spacer()
								if let url = URL(string: period.icon) {
									KFImage(url)
								}
							}
							Text(period.shortForecast)
							if !vm.isUpToDate {
								if let date = vm.location.lastUpdated {
									Text("Not up to date. Last updated date: \(date.yearMonthDayTime)")
										.font(.footnote)
										.foregroundColor(.red)
								} else {
									Text("Not up to date")
										.font(.footnote)
										.foregroundColor(.red)
								}
							}
						}
					}
				}
			}
		}
		.onAppear {
			vm.softUpdate()
		}
	}
}
