//
//  ContentView.swift
//  HabitTracker
//
//  Created by Maxim Gotovchenko on 16.07.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.createdAt, ascending: false)],
        animation: .default
    )
    private var habits: FetchedResults<Habit>

    @State private var showingAddHabit = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                Text("Мои привычки")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)

                if habits.isEmpty {
                    Spacer()
                    Text("У тебя пока нет привычек")
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(habits) { habit in
                                HabitCardView(habit: habit, context: viewContext)
                            }
                            .onDelete(perform: deleteHabit)
                        }
                        .padding(.top)
                    }
                }
            }

            // Кнопка добавить привычку
            Button(action: {
                showingAddHabit = true
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .padding()
        }
        .sheet(isPresented: $showingAddHabit) {
            AddHabitView()
                .environment(\.managedObjectContext, viewContext)
        }
    }

    private func deleteHabit(at offsets: IndexSet) {
        for index in offsets {
            let habit = habits[index]
            viewContext.delete(habit)
        }

        do {
            try viewContext.save()
        } catch {
            print("Ошибка при удалении привычки: \(error.localizedDescription)")
        }
    }
}
