//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Maxim Gotovchenko on 17.07.2025.
//

import SwiftUI
import CoreData

struct AddHabitView: View {
    @State private var title = ""
    @State private var icon = ""
    @State private var color = Color.blue
    @Environment(\.managedObjectContext) private var viewContext
    //Чтобы закрывать экран после сессии
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    var body: some View {
        NavigationView{
            Form {
                Section(header:Text("Название")){
                    TextField("Введите название", text: $title)
                }
                Section(header:Text("Иконка")){
                    TextField("Например 🌟", text: $icon)
                }
                Section(header: Text("Цвет")){
                    ColorPicker("Выберите цвет", selection: $color)
                }
                Section{
                    Button("Cохранить"){
                        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                            showAlert = true
                            return
                        }
                        
                        
                        let newHabit = Habit(context: viewContext)
                        newHabit.title = title
                        newHabit.icon = icon
                        newHabit.color = color.description
                        newHabit.createdAt = Date()
                        
                        do {
                            try viewContext.save()
                            dismiss()
                        }catch{
                            print("Ошибка при сохранении: \(error.localizedDescription)")
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .alert("Название не может быть пустым", isPresented: $showAlert){
                   Button("Ok", role: .cancel){}
        }
            .navigationTitle("Новая привычка")
        }
    }
}

#Preview {
    AddHabitView()
}
