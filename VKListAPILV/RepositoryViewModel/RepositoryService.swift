import Foundation
import Combine

class RepositoryService {
    private var cancellables = Set<AnyCancellable>()

    func fetchRepositories(page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let urlString = "https://api.github.com/search/repositories?q=swift&sort=stars&order=asc&page=\(page)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RepositoryResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { response in
                completion(.success(response.items))  
            })
            .store(in: &cancellables)
    }
}
