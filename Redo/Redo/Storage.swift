//
//  Storage.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/10.
//

import Foundation
import FMDB

public class Storage {
    public var database: FMDatabase
    init() {
        let fileManager = FileManager.default

        let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        let databaseURL = docURL.appendingPathComponent("todos.db")

        database = FMDatabase(path: databaseURL.absoluteString)        
        database.open()
        database.executeUpdate("create table if not exists todos (id TEXT, content TEXT, isDone NUMERIC);", withArgumentsIn: [])
        database.executeUpdate("create table if not exists members (id TEXT, name TEXT);", withArgumentsIn: [])
        database.executeUpdate("create table if not exists master_log (id TEXT);", withArgumentsIn: [])
    }
    
    public func loadTodos() -> [Todo] {
        var todos:[Todo] = []
        if let result = database.executeQuery("SELECT * FROM todos", withArgumentsIn: []) {
            while result.next() {
                let todo = Todo()
                todo.id = UUID(uuidString: result.string(forColumnIndex: 0) ?? UUID().uuidString) ?? UUID()
                todo.content = result.string(forColumnIndex: 1) ?? ""
                todo.isDone = result.bool(forColumnIndex: 2)
                todos.append(todo)
            }
        }
        return todos
    }
    
    public func insertTodo(id: UUID, content: String, isDone: Bool) {
        database.executeUpdate("INSERT INTO todos VALUES (?, ?, ?)", withArgumentsIn: [id.uuidString, content, isDone])
    }
    
    public func updateTodo(id: UUID, content: String, isDone: Bool) {
        database.executeUpdate("UPDATE todos SET content = ?, isDone = ? WHERE id = ?", withArgumentsIn: [content, isDone, id.uuidString])
    }
    
    public func deleteTodo(id: UUID) {
        database.executeUpdate("DELETE FROM todos WHERE id = ?", withArgumentsIn: [id.uuidString])
    }
    
    public func loadMembers() -> [Member] {
        var members:[Member] = []
        if let result = database.executeQuery("SELECT * FROM members", withArgumentsIn: []) {
            while result.next() {
                let member = Member()
                member.id = UUID(uuidString: result.string(forColumnIndex: 0) ?? UUID().uuidString) ?? UUID()
                member.name = result.string(forColumnIndex: 1) ?? ""
                members.append(member)
            }
        }
        return members
    }
    
    public func insertMember(id: UUID, name: String) {
        database.executeUpdate("INSERT INTO members VALUES (?, ?)", withArgumentsIn: [id.uuidString, name])
    }
    
    public func deleteMember(id: UUID) {
        database.executeUpdate("DELETE FROM members WHERE id = ?", withArgumentsIn: [id.uuidString])
    }

}

var todoStore = Storage()
