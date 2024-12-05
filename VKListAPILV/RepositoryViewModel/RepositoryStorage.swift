import Foundation

class RepositoryStorage {
    private let storageFileName = "repositories.json"

    func saveRepositories(_ repositories: [Repository]) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentsDirectory = urls.first else { return }

        let fileURL = documentsDirectory.appendingPathComponent(storageFileName)
        if let data = try? JSONEncoder().encode(repositories) {
            try? data.write(to: fileURL)
        }
    }

    func loadRepositories() -> [Repository]? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentsDirectory = urls.first else { return nil }

        let fileURL = documentsDirectory.appendingPathComponent(storageFileName)
        if let data = try? Data(contentsOf: fileURL),
           let savedRepositories = try? JSONDecoder().decode([Repository].self, from: data) {
            return savedRepositories
        }
        return nil
    }
}
