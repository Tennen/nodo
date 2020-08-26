import SwiftUI
import CoreData
import Foundation

class TodoState: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var selectedTodo: Todo?
}

struct TodoList: View {
    @ObservedObject var todoState = TodoState()
    @State private var editMode = EditMode.inactive
    
    func initTodos() {
        if !todoState.todos.isEmpty {
            return
        }
        todoState.todos = todoStore.loadTodos()
    }
    
    func cancelInput() {
        todoState.selectedTodo = nil
    }
    
    func insertTodo(todo: Todo) {
        todoStore.insertTodo(id: todo.id, content: todo.content, isDone: todo.isDone)
    }
    
    func onInputDone(value: String, todo: Todo) {
        if (value == "") {
            cancelInput()
            return
        }
        if ((todoState.todos.firstIndex(where: { $0.id == todo.id })) == nil) {
            todoState.selectedTodo!.content = value
            insertTodo(todo: todoState.selectedTodo!)
            todoState.todos.append(todoState.selectedTodo!)
        } else {
            todoState.selectedTodo!.content = value
            todoStore.updateTodo(id: todoState.selectedTodo!.id, content: value, isDone: todoState.selectedTodo!.isDone)
        }
        cancelInput()
    }
    
    func onAdd() {
        todoState.selectedTodo = Todo()
    }
    
    func onCheck(id: UUID, checked: Bool) {
        for index in todoState.todos.indices {
            if todoState.todos[index].id == id {
                todoState.todos[index].isDone = checked
                todoStore.updateTodo(id: id, content: todoState.todos[index].content, isDone: checked)
            }
        }

    }
    
    func onDelete(_ indexSet: IndexSet) {
        let idToRemove = todoState.todos[indexSet.first!].id
        todoState.todos.remove(atOffsets: indexSet)
        todoStore.deleteTodo(id: idToRemove)
    }
    
    func onClickText(_ todo: Todo) {
        todoState.selectedTodo = todo
    }
    
    func move(from source: IndexSet, to destination: Int) {
        todoState.todos.move(fromOffsets: source, toOffset: destination)
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
                VStack {
                    List {
                        ForEach(todoState.todos.filter{!$0.isDone}, id: \.id) { todo in
                            CheckboxFieldView(todo: todo,
                                  onClickText: {
                                    onClickText(todo)
                                  },
                                onCheck: onCheck
                            )
                        }.onDelete(perform: { indexSet in
                            onDelete(indexSet)
                        }).onMove(perform: move)
                        ForEach(todoState.todos.filter{$0.isDone}, id: \.id) { todo in
                            CheckboxFieldView(todo: todo,
                                  onClickText: {
                                    onClickText(todo)
                                  },
                                onCheck: onCheck
                            )
                        }.onDelete(perform: { indexSet in
                            onDelete(indexSet)
                        })
                    }.environment(\.editMode, $editMode)
                }
                HStack(spacing: 10) {
                    Button(action: onAdd) {
                        Image(systemName: "plus")
                            .foregroundColor(baseColor)
                            .frame(width: 50, height: 50)
                    }
                }
            }.sheet(item: $todoState.selectedTodo){ todo in
                InputView(onDone: {
                    onInputDone(value: $0, todo: todo)
                }, onCancel: cancelInput,content: todo.content)
            }
            .navigationBarTitle("Redo")
            .navigationBarItems(leading: EditButton())
            .onAppear(perform: {
                initTodos()
            })
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
