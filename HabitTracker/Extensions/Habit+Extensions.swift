//
//  Habit+Extensions.swift
//  HabitTracker
//
//  Created by Maxim Gotovchenko on 17.07.2025.
//

import Foundation
import SwiftUI
import CoreData

extension Habit {
    var wrappedTitle: String {
        title ?? "Без названия"
    }
    
    var wrappedIcon: String {
        icon ?? "star"
    }
    var wrappedColor: String {
        color ?? "gray"
    }
    
    
    var uiColor: Color {
        Color(wrappedColor)
    }
    var isCompleted: Bool {
        //Пока заглушка
        return self.isCompletedToday
    }
    var formattedCreatedAt: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return createdAt.map { formatter.string(from: $0)} ?? "неизвестно"
    }
}
