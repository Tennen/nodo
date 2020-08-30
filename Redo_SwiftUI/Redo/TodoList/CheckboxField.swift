import SwiftUI

struct CheckboxFieldView : View {
    @ObservedObject var todo: Todo;
    
    var onClickText: (() -> Void)?;
    
    var onCheck: ((_ id: UUID, _ checked: Bool) -> Void)?;
    
    @State var showDelete: Bool = false

    var body: some View {
        HStack(){
            Image(systemName: (todo.isDone ? "checkmark.square" : "square"))
                .padding(2)
                .font(.system(size: 25))
                .onTapGesture {
                    onCheck?(todo.id, !todo.isDone)
                }
            Text(todo.content)
                .strikethrough(todo.isDone)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .contentShape(Rectangle())
                .onTapGesture {
                    onClickText?()
                }
        }
        .frame(height: 40)
    }

}

struct CheckboxField_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
