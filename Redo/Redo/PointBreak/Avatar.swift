//
//  Avatar.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/13.
//

import SwiftUI

struct Avatar: View {
    var body: some View {
        _KFImage("makima.jpg")
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .fixedSize()
            .frame(width: 50, height: 50)
            .scaleEffect(x: 0.5, y: 0.5)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
    }
}
