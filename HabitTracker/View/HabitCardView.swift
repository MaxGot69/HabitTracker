//
//  HabitCardView.swift
//  HabitTracker
//
//  Created by Maxim Gotovchenko on 18.07.2025.
//

import SwiftUI
import CoreData

struct HabitCardView: View {
    var habit: Habit
    var context: NSManagedObjectContext
    
    var body: some View {
        HStack(spacing:16){
            //Иконка привычки
            Image(systemName: habit.wrappedIcon)
                .font(.title2)
                .padding()
                .background(habit.uiColor.opacity(0.2))
                .clipShape(Circle())
                .foregroundColor(habit.uiColor)
            
            //Название + дата
            VStack(alignment: .leading, spacing: 4){
                Text(habit.wrappedTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Создано: \(habit.formattedCreatedAt)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            Spacer()
            //Галочка если выполено
            if habit.isCompletedToday {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
                    .transition(.scale)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .onTapGesture {
            withAnimation{
                habit.isCompletedToday.toggle()
                do{
                    try? context.save()
                } catch {
                    print("Ошика при сохранении статуса: \(error.localizedDescription)")
                }
            }
        }
        .padding(.horizontal)
    }
}

