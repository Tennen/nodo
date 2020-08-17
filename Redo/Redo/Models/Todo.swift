import Foundation
import CoreData

public class Todo: ObservableObject {
    @Published public var id: UUID = UUID()
    @Published public var content: String = ""
    @Published public var isDone: Bool = false
}
