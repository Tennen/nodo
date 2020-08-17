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
            Button(action: {}) {
                Text("Delete")
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .fixedSize()
                    .frame(height: 80)
            }.offset(x: showDelete ? 0 : 200)
        }
        .frame(height: 40)
        .gesture(DragGesture().onEnded{
            if $0.translation.width < -100 {
                withAnimation {
                    showDelete = true
                }
            }
            if $0.translation.width > 100 {
                withAnimation {
                    showDelete = false
                }
            }
        })
    }

}

struct CheckboxField_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
