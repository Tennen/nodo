//
//  InputView.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/7.
//

import SwiftUI

struct InputView: View {
    @State var text: String = "";
    var onDone: ((_ value: String) -> Void)? = nil;
    var onCancel: (() -> Void)? = nil;
    var content: String = ""

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text("Redo")
                        .foregroundColor(baseColor)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                HStack {
                    Spacer()
                    Text("Done")
                        .foregroundColor(baseColor)
                        .onTapGesture {
                            onDone?(text)
                        }
                }.padding(10)
            }
            TextEditor(text: $text)
                .frame(minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .edgesIgnoringSafeArea(.all)
            Spacer()
        }.padding(10)
        .navigationBarHidden(true)
        .onAppear(perform: {
            text = content
        })
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
