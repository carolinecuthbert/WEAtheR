//
//  weatherApp.swift
//  weather
//
//  Created by Scholar on 6/21/24.
//

import SwiftUI
import SwiftData

@main
struct WEAtheRApp: App {
    var container: ModelContainer
        
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try! ModelContainer(for: TripItem.self, ListItem.self, configurations: config)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}
