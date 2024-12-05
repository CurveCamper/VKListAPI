import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case original = "Original"
    case name = "Name"
    case hasDescription = "Description"

    var id: String { self.rawValue }
}
