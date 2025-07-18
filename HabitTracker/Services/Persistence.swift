//
//  Persistence.swift
//  HabitTracker
//
//  Created by Maxim Gotovchenko on 17.07.2025.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "HabitModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores {description, error in
            if let error = error {
                fatalError("Ошибка при загрузке хранилища: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
