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
    @State var name: String = ""
    func loadMembers() {
        if members.isEmpty {
            return
        }
        members = todoStore.loadMembers()
        
    }
    
    func addMember() {
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
        name = ""
    }
    
    func removeMember(member: Member) {
        withAnimation {
            members = members.filter({
                $0.id != member.id
            })
        }
        todoStore.deleteMember(id: member.id)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Ramdom大法")
                HStack {
                    TextField("Enter name", text: $name)
                    Button(action: addMember) {
                        Text("确认")
                    }
                }
                .padding(.horizontal)
                List {
                    ForEach(members, id: \.id) { member in
                        HStack {
                            Text(member.name)
                            Spacer()
                            Button(action: {
                                removeMember(member: member)
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity)
        }
        .navigationTitle("Point Break")
        .onAppear(perform: loadMembers)
    }
}

struct PointBreak_Previews: PreviewProvider {
    static var previews: some View {
        PointBreak()
    }
}
