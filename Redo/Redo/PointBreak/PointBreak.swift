//
//  PointBreak.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/13.
//

import SwiftUI

struct PointBreak: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("扣命大程序")
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity)
        }.navigationTitle("Point Break")
    }
}

struct PointBreak_Previews: PreviewProvider {
    static var previews: some View {
        PointBreak()
    }
}
