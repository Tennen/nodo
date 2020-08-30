import Foundation

public class Member: ObservableObject {
    @Published public var id: UUID = UUID()
    @Published public var name: String = ""
}
