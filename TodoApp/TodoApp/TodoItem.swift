import Foundation
import SwiftData

enum Priority: Int, Codable, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2

    var label: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }

    var color: String {
        switch self {
        case .low: return "green"
        case .medium: return "orange"
        case .high: return "red"
        }
    }
}

@Model
final class TodoItem {
    var id: UUID
    var title: String
    var notes: String
    var priority: Priority
    var dueDate: Date?
    var isCompleted: Bool
    var createdAt: Date

    init(title: String, notes: String = "", priority: Priority = .medium, dueDate: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.notes = notes
        self.priority = priority
        self.dueDate = dueDate
        self.isCompleted = false
        self.createdAt = Date()
    }
}
