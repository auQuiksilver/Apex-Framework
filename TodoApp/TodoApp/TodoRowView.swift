import SwiftUI

struct TodoRowView: View {
    @Bindable var item: TodoItem

    var body: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation(.spring(response: 0.3)) {
                    item.isCompleted.toggle()
                }
            } label: {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(item.isCompleted ? .green : .secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .strikethrough(item.isCompleted)
                    .foregroundStyle(item.isCompleted ? .secondary : .primary)

                HStack(spacing: 8) {
                    priorityBadge
                    if let due = item.dueDate {
                        dueDateLabel(due)
                    }
                }

                if !item.notes.isEmpty {
                    Text(item.notes)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }

    private var priorityBadge: some View {
        Text(item.priority.label)
            .font(.caption2.bold())
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(priorityColor.opacity(0.15))
            .foregroundStyle(priorityColor)
            .clipShape(Capsule())
    }

    private var priorityColor: Color {
        switch item.priority {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }

    private func dueDateLabel(_ date: Date) -> some View {
        let isOverdue = date < Date() && !item.isCompleted
        return Label(date.formatted(date: .abbreviated, time: .omitted), systemImage: "calendar")
            .font(.caption2)
            .foregroundStyle(isOverdue ? .red : .secondary)
    }
}
