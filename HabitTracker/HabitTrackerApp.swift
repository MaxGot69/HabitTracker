//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Maxim Gotovchenko on 16.07.2025.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
