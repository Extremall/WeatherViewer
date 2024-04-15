//
//  LocationList.swift
//  WeatherViewer
//
//  Created by Extremall on 13/04/2024.
//

import SwiftUI
import CoreData

struct LocationListView: View {
	@Environment(\.managedObjectContext) private var viewContext
	
	@ObservedObject var vm: LocationListViewModel
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \CoreDataLocation.city, ascending: true)],
		animation: .default)
	var locations: FetchedResults<CoreDataLocation>
	
	@State var showActionSheet: Bool = false
	@State var showGPSSheet: Bool = false
	@State var showFindLocationSheet: Bool = false
	
	init(vm: LocationListViewModel) {
		self.vm = vm
	}
	
	var body: some View {
		NavigationView {
			List {
				if locations.isEmpty {
					Text("Add Location by clicking \"+\" button")
				}
				ForEach(locations) { location in
					NavigationLink {
						LocationView(vm:
										LocationViewModel(
											location: Location(coreDataObject: location),
											periods: location.periods.map { Period(coreDataObject: $0) }.sorted(by: { $0.startTime < $1.endTime })
										)
						)
					} label: {
						LocationShortView(vm:
											LocationShortViewModel(
												location: Location(coreDataObject: location),
												periods: location.periods.map { Period(coreDataObject: $0) }.sorted(by: { $0.startTime < $1.endTime }),
												context: viewContext)
						)
					}
				}
				.onDelete(perform: deleteItems)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
				ToolbarItem {
					Button(action: addItem) {
						Label("Add Item", systemImage: "plus")
					}
				}
				ToolbarItem {
					Button(action: update) {
						Label("Update", systemImage: "arrow.triangle.2.circlepath")
					}
				}
			}
			.confirmationDialog("Add a location", isPresented: $showActionSheet) {
				Button("Using GPS coordinates", role: .none) {
					showGPSSheet = true
				}
				Button("Find location", role: .none) {
					showFindLocationSheet = true
				}
				Button("Cancel", role: .cancel) { }
			}
			.sheet(isPresented: $showGPSSheet) {
				AddByGPSView(vm: AddByGPSViewModel(context: viewContext, showModal: $showGPSSheet))
			}
			.sheet(isPresented: $showFindLocationSheet) {
				FindLocationView(vm: FindLocationViewModel(context: viewContext, showModal: $showFindLocationSheet))
			}
		}
	}
	
	private func addItem() {
		showActionSheet = true
	}
	
	private func update() {
		vm.update()
	}

	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map { locations[$0] }.forEach(viewContext.delete)

			do {
				try viewContext.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
}

//#Preview {
//	LocationListView()
//		.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
