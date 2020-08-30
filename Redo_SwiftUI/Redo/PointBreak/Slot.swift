//
//  Slot.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/20.
//

import Foundation
import SwiftUI
import Combine

let Dark = Color(red: 153 / 255, green: 28 / 255, blue: 72 / 255)

let Pink = Color(red: 235 / 255, green: 117 / 255, blue: 137 / 255)

let Yellow = Color(red: 254 / 255, green: 200 / 255, blue: 140 / 255)

struct SlotView: View {
    @State var handleHeight: CGFloat = 80
    @State var currentIndex: Int = 0
    @Binding var data: [Member]
    @State var wrappedData: [Member] = []
    
    func getRangdom() -> Int {
        return Int.random(in: 0..<data.count)
    }
    
    var body: some View {
        let drag = DragGesture()
            .onChanged{
                if $0.translation.height > 0 && $0.translation.height < 80 {
                    let nextHeight = 80 - $0.translation.height
                    withAnimation {
                        self.handleHeight = nextHeight
                    }
                }
            }.onEnded({_ in
                timer.connectTimer()
                withAnimation {
                    handleHeight = 80
                }
            })
        VStack {
            VStack {
                HStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 30, height: 4)
                        .background(Color.white)
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 10, height: 4)
                        .background(Color.white)
                    Spacer()
                    Text("Master Slot")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 10, height: 4)
                        .background(Color.white)
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 30, height: 4)
                        .background(Color.white)
                }
                Spacer()
            }
                .padding()
                .frame(width: 270, height: 45)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Pink)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Dark, lineWidth: 4)
                )
            ZStack {
                VStack {
                    HStack(spacing: 16) {
                        Slot(data: wrappedData)
                    }
                    Spacer()
                    HStack(spacing: 16) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Pink)
                        Image(systemName: "star.fill")
                            .foregroundColor(Pink)
                        Image(systemName: "star.fill")
                            .foregroundColor(Pink)
                    }
                    Spacer()
                    HStack(spacing: 20) {
                        Circle()
                            .fill(Pink)
                            .overlay(Circle().stroke(Dark, lineWidth: 4))
                            .frame(width: 20)
                        RoundedCorners(bl: 10, br: 10)
                            .fill(Color.white)
                            .overlay(
                                RoundedCorners(bl: 10, br: 10)
                                    .stroke(Dark, lineWidth: 4)
                            )
                            .frame(width: 120, height: 20)
                        Circle()
                            .fill(Pink)
                            .overlay(Circle().stroke(Dark, lineWidth: 4))
                            .frame(width: 20)
                    }.frame(height: 40)
                }
                    .padding()
                    .frame(width: 230, height: 280)
                    .background(
                        RoundedCorners(bl: 10, br: 10)
                            .fill(Yellow)
                    )
                    .overlay(
                        RoundedCorners(bl: 10, br: 10)
                            .stroke(Dark, lineWidth: 4)
                    )
                RoundedRectangle(cornerRadius: 4)
                    .fill(Pink)
                    .frame(width: 270, height: 16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Dark, lineWidth: 4)
                    )
                    .offset(y: 70)
                HStack {
                    Rectangle()
                        .fill(Pink)
                        .frame(width: 10, height: 20)
                        .overlay(
                            Rectangle()
                                .stroke(Dark, lineWidth: 4)
                        )
                }
                    .frame(width: 40, height: 20)
                    .background(
                        RoundedCorners(tr: 4, br: 4)
                            .fill(Yellow)
                    )
                    .overlay(
                        RoundedCorners(tr: 4, br: 4)
                            .stroke(Dark, lineWidth: 4)
                    )
                    .offset(x: 135, y: 30)
                VStack(spacing: 0) {
                    if handleHeight < 80 {
                        Spacer()
                    }
                    Circle()
                        .fill(Pink)
                        .overlay(Circle().stroke(Dark, lineWidth: 4))
                        .frame(width: 20 * (1.5 - handleHeight / 80 / 2), height: 20 * (1.5 - handleHeight / 80 / 2))
                        .gesture(drag)
                    Rectangle()
                        .fill(Yellow)
                        .frame(width: 6, height: handleHeight)
                        .overlay(
                            Rectangle()
                                .stroke(Dark, lineWidth: 4)
                        )
                }
                .frame(height: 100)
                .offset(x: 145, y: -30)
            }
        }.onAppear{
            wrappedData = data.map{$0}.shuffled()
        }
    }
}

struct Slot: View {
    @State var currentIndex: Int = 0
    @State var round: Int = 0
    var data: [Member] = []
        
    var body: some View {
        VStack(spacing: 0){
            RoundedCorners(tl: 4)
                .fill(Pink)
                .frame(height: 5)
            Rectangle()
                .fill(Dark)
                .frame(height: 4)
            VStack() {
                ForEach(0..<data.count, id: \.self) {
                    index in
                    HStack {
                        Spacer()
                        Text(data[index].name)
                            .foregroundColor(Pink)
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }.frame(height: 80)
                }.offset(y: CGFloat(
                    (data.count/2  - currentIndex) * 80
                    ) - (data.count % 2 == 0 ? 40: 0))
                .onReceive(timer.currentTimePublisher) { time in
                    if round == 4 && currentIndex == Int(data.count / 2) {
                        timer.cancelTimer()
                        return
                    }
                    if (currentIndex == data.count - 1) {
                        round += 1
                        currentIndex = 0
                    }
                    withAnimation {
                        currentIndex += 1
                    }
                }
            }
                .frame(height: 80)
                .background(Color.white)
                .clipShape(Rectangle())
            Rectangle()
                .fill(Dark)
                .frame(height: 4)
            RoundedCorners(br: 4)
                .fill(Pink)
                .frame(height: 6)
        }.overlay(
            RoundedCorners(tl: 4, br: 4)
                .stroke(Dark, lineWidth: 4)
        )
    }
}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.addLine(to: CGPoint(x: w / 2, y: 0))
        return path
    }
}
