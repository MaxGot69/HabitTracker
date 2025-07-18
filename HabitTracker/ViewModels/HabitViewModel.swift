//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Maxim Gotovchenko on 16.07.2025.
//
//ObservableObject делает ViewModel наблюдаемой(UI обновляется если меняется published свойство )
//@Published var habits: массив привычек, UI будет следить за ним

import Foundation
import CoreData

class HabitViewModel: ObservableObject{
    let container: NSPersistentContainer
    //Все привычки
    @Published var habits: [Habit] = []
    
    init(){
        container = PersistenceController.shared.container
        fetchHabits()
    }
    func fetchHabits(){
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        do{
            let result = try container.viewContext.fetch(request)
                habits = result
            }catch{
                print("Ошибка при загрузке привычек: \(error)")
            }
        }

    //Метод для добавления новой привычки
    
    func addHabit(title: String, icon: String, color: String){
        let newHabit = Habit(context: container.viewContext)
        newHabit.id = UUID()
        newHabit.title = title
        newHabit.icon = icon
        newHabit.color = color
        newHabit.isCompletedToday = false
        
        saveContext()
        fetchHabits()
    }
    func saveContext(){
        do {
            try container.viewContext.save()
        }catch{
            print("Ошибка сохранения: \(error)")
        }
    }
}

