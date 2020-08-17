import SwiftUI
import CoreData
import Foundation


struct TodoList: View {
    @State var todos: [Todo] = []
    @State private var showModal: Bool = false
    @State var selectedTodo: Todo?
    
    func initTodos() {
        if !todos.isEmpty {
            return
        }
        todos = todoStore.loadTodos()
    }
    
    func cancelInput() {
        selectedTodo = nil;
        showModal = false
    }
    
    func insertTodo(todo: Todo) {
        todoStore.insertTodo(id: todo.id, content: todo.content, isDone: todo.isDone)
    }
    
    func onInputDone(value: String) {
        if (value == "") {
            selectedTodo = nil;
            showModal = false
            return
        }
        if (selectedTodo == nil) {
            let todo = Todo()
            todo.content = value
            insertTodo(todo: todo)
            todos.append(todo)
        } else {
            for index in self.todos.indices {
                if todos[index].id == selectedTodo?.id {
                    todos[index].content = value
                    todoStore.updateTodo(id: selectedTodo!.id, content: value, isDone: todos[index].isDone)
                }
            }
        }
        selectedTodo = nil;
        showModal = false
    }
    
    func onAdd() {
        showModal = true
        selectedTodo = nil
    }
    
    func onCheck(id: UUID, checked: Bool) {
        for index in self.todos.indices {
            if todos[index].id == id {
                todos[index].isDone = checked
                todoStore.updateTodo(id: id, content: todos[index].content, isDone: checked)
            }
        }
    }
    
    func onDelete(indexSet: IndexSet) {
        let idToRemove = todos[indexSet.first!].id
        todos.remove(atOffsets: indexSet)
        todoStore.deleteTodo(id: idToRemove)
    }
    
    init () {
        let barAppearance = UINavigationBar.appearance()
        barAppearance.titleTextAttributes = [.foregroundColor:baseUIColor]
        barAppearance.largeTitleTextAttributes = [.foregroundColor:baseUIColor]
        barAppearance.barTintColor = UIColor.white
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    ForEach(self.todos, id: \.id) { todo in
                        CheckboxFieldView(todo: todo, onClickText: {
                                selectedTodo = todo
                                showModal = true
                            },
                            onCheck: onCheck
                        )
                    }
                }
                .padding(.bottom, 50)
//                .padding(.horizontal)
                .onAppear(perform: { self.initTodos() })
                HStack(spacing: 10) {
                    Button(action: onAdd) {
                        Image(systemName: "plus")
                            .foregroundColor(baseColor)
                            .frame(width: 50, height: 50)
                    }
                }
            }.sheet(isPresented: $showModal){
                InputView(onDone: onInputDone, onCancel: cancelInput,data: $selectedTodo)
            }
            .navigationBarTitle("Redo")
        }
    }
}
