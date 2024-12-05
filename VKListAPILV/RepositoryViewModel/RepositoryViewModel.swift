import Foundation
import SwiftUI
import Combine

class RepositoryViewModel: ObservableObject {
    @Published var repositories: [Repository] = [] {
        didSet {
            saveRepositoriesToStorage()
        }
    }
    @Published var isLoading = false
    @Published var sortOption: SortOption = .original {
        didSet {
            sortRepositories()
        }
    }

    private var originalRepositories: [Repository] = []
    private var currentPage = 1
    var canLoadMore = true
    private var cancellables = Set<AnyCancellable>()

    private let repositoryService = RepositoryService()
    private let storage = RepositoryStorage()

    init() {
        loadRepositoriesFromStorage()
    }

    func fetchRepositories() {
        guard !isLoading, canLoadMore else { return }
        isLoading = true

        repositoryService.fetchRepositories(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .failure:
                    self?.canLoadMore = false
                case .success(let newRepositories):
                    self?.originalRepositories.append(contentsOf: newRepositories)
                    self?.repositories = self?.originalRepositories ?? []
                    self?.sortRepositories()
                    self?.currentPage += 1
                    self?.canLoadMore = !newRepositories.isEmpty
                }
            }
        }
    }

    private func sortRepositories() {
        repositories = RepositorySorter.sort(originalRepositories, by: sortOption)
    }

    func deleteRepository(_ repository: Repository) {
        originalRepositories.removeAll { $0.id == repository.id }
        repositories.removeAll { $0.id == repository.id }
    }

    func updateRepository(_ repository: Repository, newName: String, newDescription: String?) {
        if let index = originalRepositories.firstIndex(where: { $0.id == repository.id }) {
            let updatedRepository = Repository(id: repository.id, name: newName, description: newDescription, stargazers_count: repository.stargazers_count, owner: repository.owner)
            originalRepositories[index] = updatedRepository
            sortRepositories()
        }
    }

    private func saveRepositoriesToStorage() {
        storage.saveRepositories(originalRepositories)
    }

    private func loadRepositoriesFromStorage() {
        if let savedRepositories = storage.loadRepositories() {
            originalRepositories = savedRepositories
            repositories = originalRepositories
        }
    }
}
