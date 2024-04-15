//
//  LocationView.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import Foundation
import SwiftUI

struct LocationView: View {
	@ObservedObject var vm: LocationViewModel

	var body: some View {
		VStack {
			List {
				ForEach(vm.periods) { period in
					LocationDetailsCell(vm: LocationDetailsViewModel(period: period))
						.listRowBackground(period.isDaytime ? Color.white : Color(uiColor: UIColor.lightGray))
				}
			}
		}
		.onAppear {
		}
	}
}
