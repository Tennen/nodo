//
//  SceneDelegate.swift
//  Redo
//
//  Created by 陈天宇 on 2020/8/9.
//

import Foundation
import CoreData

// 1
var persistentContainer: NSPersistentContainer = {
  // 2
  let container = NSPersistentContainer(name: "Todos")
  // 3
  container.loadPersistentStores { _, error in
    // 4
    if let error = error as NSError? {
      // You should add your own error handling code here.
      fatalError("Unresolved error \(error), \(error.userInfo)")
    }
  }
  return container
}()

func saveContext() {
  // 1
  let context = persistentContainer.viewContext
  // 2
  if context.hasChanges {
    do {
      // 3
      try context.save()
    } catch {
      // 4
      // The context couldn't be saved.
      // You should add your own error handling here.
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
}
