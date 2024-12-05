import Foundation

struct RepositorySorter {
    static func sort(_ repositories: [Repository], by option: SortOption) -> [Repository] {
        switch option {
        case .original:
            return repositories
        case .name:
            return repositories.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .hasDescription:
            return repositories.sorted {
                ($0.description != nil ? 0 : 1) < ($1.description != nil ? 0 : 1)
            }
        }
    }
}

