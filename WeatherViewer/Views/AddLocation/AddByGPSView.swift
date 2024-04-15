//
//  AddByGPSView.swift
//  WeatherViewer
//
//  Created by Extremall on 14/04/2024.
//

import SwiftUI

struct AddByGPSView: View {
	@ObservedObject var vm: AddByGPSViewModel
	
	init(vm: AddByGPSViewModel) {
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
			Spacer()
			VStack {
				Text("GPS coordinates:")
					.font(.title2)
					.padding(.bottom, 20)
				TextField("Latitude", text: $vm.latitude)
					.padding()
					.background(Color.white)
					.cornerRadius(5)
					.overlay(
						RoundedRectangle(cornerRadius: 5)
							.stroke(Color.gray, lineWidth: 1)
					)
					.padding()
				TextField("Longitude", text: $vm.longitude)
					.padding()
					.background(Color.white)
					.cornerRadius(5)
					.overlay(
						RoundedRectangle(cornerRadius: 5)
							.stroke(Color.gray, lineWidth: 1)
					)
					.padding()
			}.padding(.horizontal, 20)
			Button("Find") {
				if let lat = Double(vm.latitude), let long = Double(vm.longitude) {
					vm.find(latitude: lat, longitude: long)
				}
			}
			.padding(.top, 20)
			Button("Fill with the current location") {
				vm.getCurrentCoordinate()
			}
			.padding(.top, 20)
			Spacer()
			if let result = vm.searchResult {
				Text("Results:")
					.font(.title2)
					.padding(.bottom, 20)
				Text("City: \(result.properties.relativeLocation.properties.city)")
				Text("State: \(result.properties.relativeLocation.properties.state)")
				Text("GridID: \(result.properties.gridId)")
				Text("GridX: \(result.properties.gridX)")
				Text("GridY: \(result.properties.gridY)")
				if vm.locationExists {
					Text("You have this location in the list")
						.font(.title2)
						.foregroundColor(.blue)
				} else {
					Button("Add to list") {
						vm.addToList()
					}
					.font(.title2)
					.padding(.top, 20)
				}
				Spacer()
			} else if vm.failedSearch {
				Text("No objects found")
					.font(.title2)
					.padding(.bottom, 20)
			}
		}
	}
}
