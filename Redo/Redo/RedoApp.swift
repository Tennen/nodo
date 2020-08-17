//
//  RedoApp.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/1.
//

import SwiftUI

@main
struct RedoApp: App {
    @Environment(\.managedObjectContext) var context
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, context)
        }
    }
}

struct RedoApp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
