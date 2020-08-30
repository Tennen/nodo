//
//  PointBreak.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/13.
//

import SwiftUI
import Foundation

struct PointBreak: View {
    @State var members: [Member] = []
    @State var showModal: Bool = false
    @State var name: String = ""
    func loadMembers() {
        if !members.isEmpty {
            return
        }
        members = todoStore.loadMembers()
        
    }
    
    func onInputDone() {
        if (name == "") {
            return
        }
        let member = Member()
        member.id = UUID()
        member.name = name
        withAnimation {
            members.append(member)
        }
        todoStore.insertMember(id: member.id, name: member.name)
        cancelInput()
    }
    
    func cancelInput() {
        name = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func removeMember(index: IndexSet) {
        let memberId = members[index.first!].id
        members.remove(atOffsets: index)
        todoStore.deleteMember(id: memberId)
    }
    
    func onShuffle() {
        showModal = true
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
                    Spacer()
                    HStack {
                        TextField("Enter member name", text: $name)
                        Button(action: onInputDone) {
                            Text("Add")
                                .foregroundColor(baseColor)
                        }
                    }.padding(.horizontal)
                    List {
                        ForEach(0..<members.count, id: \.self) { index in
                            HStack {
                                Text(members[index].name)
                            }
                        }.onDelete(perform: { indexSet in
                            removeMember(index: indexSet)
                        })
                    }
                    HStack(spacing: 10) {
                        Spacer()
                        Button(action: onShuffle) {
                            Text("Slot")
                                .foregroundColor(baseColor)
                        }
                        Spacer()
                    }.frame(height: 50)
                }
            }
            .navigationBarTitle("Master Slot")
        }.sheet(isPresented: $showModal){
            SlotView(data: $members)
        }
        .onAppear(perform: loadMembers)
    }
}

struct PointBreak_Previews: PreviewProvider {
    static var previews: some View {
        PointBreak()
    }
}
