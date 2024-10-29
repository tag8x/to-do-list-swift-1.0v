import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
}

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var completedTodos: [TodoItem] = []
    @State private var newTodoTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Yeni görev ekle", text: $newTodoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: addTodo) {
                        Text("Ekle")
                    }
                    .padding()
                }

                List {
                    Section(header: Text("Görevler")) {
                        ForEach(todos) { todo in
                            HStack {
                                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .onTapGesture {
                                        toggleCompletion(for: todo)
                                    }
                                Text(todo.title)
                                    .strikethrough(todo.isCompleted)
                            }
                        }
                        .onDelete(perform: deleteTodo)
                    }

                    Section(header: Text("Tamamlanan Görevler")) {
                        ForEach(completedTodos) { todo in
                            Text(todo.title)
                        }
                        .onDelete(perform: deleteCompletedTodo)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationTitle("Todo List")
            .navigationBarItems(trailing: Button("Temizle") {
                clearOldCompletedTodos()
            })
        }
    }

    private func addTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = TodoItem(title: newTodoTitle)
        todos.append(newTodo)
        newTodoTitle = ""
    }

    private func toggleCompletion(for todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
            if todos[index].isCompleted {
                completedTodos.append(todos[index])
                todos.remove(at: index)
            }
        }
    }

    private func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }

    private func deleteCompletedTodo(at offsets: IndexSet) {
        completedTodos.remove(atOffsets: offsets)
    }

    private func clearOldCompletedTodos() {
        completedTodos.removeAll { completedTodo in
            let daysPassed = Calendar.current.dateComponents([.day], from: completedTodo.createdAt, to: Date()).day ?? 0
            return daysPassed >= 30
        }
    }
}

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
