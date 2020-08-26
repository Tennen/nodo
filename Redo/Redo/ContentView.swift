//
//  ContentView.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/1.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showMenu: Bool = false
    @State var activatedMenu: MenuKey = .TODO
    
    func onSwitchMenu (key: MenuKey) {
        withAnimation {
            showMenu = false
        }
        withAnimation {
            activatedMenu = key
        }
    }
    
    init () {
        let barAppearance = UINavigationBar.appearance()
        barAppearance.titleTextAttributes = [.foregroundColor:baseUIColor]
        barAppearance.largeTitleTextAttributes = [.foregroundColor:baseUIColor]
        barAppearance.barTintColor = UIColor.white
    }

    var body: some View {
        GeometryReader { geometry in
            let drag = DragGesture().onEnded{
                if $0.translation.width < -50 {
                    withAnimation {
                        self.showMenu = false
                    }
                    return
                }
                if $0.startLocation.x < 10 && $0.translation.width > 50 {
                    withAnimation {
                        self.showMenu = true
                    }
                    return
                }
            }
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    switch (activatedMenu) {
                        case .TODO:
                            TodoList()
                        case .POINT:
                            PointBreak()
                    }
                }.disabled(showMenu)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: showMenu ? geometry.size.width/2 : 0)
                .frame(width: geometry.size.width, height: geometry.size.height)
                if showMenu {
                    MenuView(activatedMenu: $activatedMenu, onSwitchMenu: onSwitchMenu)
                        .frame(width: geometry.size.width/2)
                }
            }.gesture(drag)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
