import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case dateCreated = "Date Created"
    case dueDate = "Due Date"
    case priority = "Priority"
    case title = "Title"
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allItems: [TodoItem]

    @State private var showingAddTodo = false
    @State private var sortOption: SortOption = .dateCreated
    @State private var showCompleted = true
    @State private var searchText = ""

    var pendingItems: [TodoItem] {
        filtered(items: allItems.filter { !$0.isCompleted })
    }

    var completedItems: [TodoItem] {
        filtered(items: allItems.filter { $0.isCompleted })
    }

    var body: some View {
        NavigationStack {
            Group {
                if allItems.isEmpty {
                    emptyState
                } else {
                    todoList
                }
            }
            .navigationTitle("My Todos")
            .searchable(text: $searchText, prompt: "Search todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Sort By", selection: $sortOption) {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        Divider()
                        Toggle("Show Completed", isOn: $showCompleted)
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddTodo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTodo) {
                AddTodoView()
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "checklist")
                .font(.system(size: 64))
                .foregroundStyle(.secondary)
            Text("No Todos Yet")
                .font(.title2.bold())
            Text("Tap + to add your first task")
                .foregroundStyle(.secondary)
            Button("Add Todo") {
                showingAddTodo = true
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var todoList: some View {
        List {
            if !pendingItems.isEmpty {
                Section("Pending (\(pendingItems.count))") {
                    ForEach(pendingItems) { item in
                        TodoRowView(item: item)
                    }
                    .onDelete { indexSet in
                        delete(from: pendingItems, at: indexSet)
                    }
                }
            }

            if showCompleted && !completedItems.isEmpty {
                Section("Completed (\(completedItems.count))") {
                    ForEach(completedItems) { item in
                        TodoRowView(item: item)
                    }
                    .onDelete { indexSet in
                        delete(from: completedItems, at: indexSet)
                    }
                }
            }
        }
    }

    private func filtered(items: [TodoItem]) -> [TodoItem] {
        let searched = searchText.isEmpty ? items : items.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.notes.localizedCaseInsensitiveContains(searchText)
        }
        return sorted(items: searched)
    }

    private func sorted(items: [TodoItem]) -> [TodoItem] {
        switch sortOption {
        case .dateCreated:
            return items.sorted { $0.createdAt > $1.createdAt }
        case .dueDate:
            return items.sorted {
                guard let d1 = $0.dueDate else { return false }
                guard let d2 = $1.dueDate else { return true }
                return d1 < d2
            }
        case .priority:
            return items.sorted { $0.priority.rawValue > $1.priority.rawValue }
        case .title:
            return items.sorted { $0.title < $1.title }
        }
    }

    private func delete(from items: [TodoItem], at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
