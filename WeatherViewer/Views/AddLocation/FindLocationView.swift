//
//  FindLocationView.swift
//  WeatherViewer
//
//  Created by Extremall on 14/04/2024.
//

import SwiftUI

struct FindLocationView: View {
	@ObservedObject var vm: FindLocationViewModel
	@State var query: String = ""
	
	init(vm: FindLocationViewModel) {
		self.vm = vm
	}
	
	var body: some View {
		VStack {
			HStack{
				Spacer()
				Button(action: {
					vm.showModal.wrappedValue = false
				}) {
					Image(systemName: "xmark")
						.padding()
				}
			}
			VStack {
				Text("Find your location:")
					.font(.title2)
					.padding(.bottom, 20)
				TextField("Query", text: $query)
					.padding()
					.background(Color.white)
					.cornerRadius(5)
					.overlay(
						RoundedRectangle(cornerRadius: 5)
							.stroke(Color.gray, lineWidth: 1)
					)
					.padding()
					.onChange(of: query) { newValue in
						print("new query: \(newValue)")
						vm.findLocation(query: newValue)
					}
			}
			.padding(.horizontal, 20)
			.padding(.top, 50)
			Text("Service doesn't work and hasn't been finished since I couldn't get API Key for Google Places")
				.font(.caption)
				.foregroundColor(.red)
			if !vm.places.isEmpty {
				List {
					ForEach(vm.places) { place in
						Text("\(place.address)")
					}
				}
			}
			Spacer()
		}
	}
}
