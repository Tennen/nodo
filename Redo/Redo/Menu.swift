import SwiftUI

enum MenuKey {
    case TODO
    case POINT
}

struct MenuItem {
    var key: MenuKey = .TODO
    var label: String = ""
    var tag: String = ""
}

let MenuItems = [MenuItem(key: .TODO, label: "Todo", tag: "tag"),
                 MenuItem(key: .POINT, label: "Point", tag: "heart.slash.circle")]

struct MenuView: View {
    @State var activatedMenu: MenuKey = .TODO
    var onSwitchMenu: ((_ key: MenuKey) -> Void)? = nil
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(MenuItems, id: \.key) { item in
                HStack {
                    Image(systemName: item.tag)
                        .foregroundColor(.white)
                        .imageScale(.large)
                    Text(item.label)
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(activatedMenu == item.key ? baseColorFade : baseColor)
                .onTapGesture {
                    withAnimation {
                        onSwitchMenu?(item.key)
                        activatedMenu = item.key
                    }
                }
            }
            Spacer()
        }.padding(.top, 100)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(baseColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
