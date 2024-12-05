import Foundation

struct Owner: Codable {
    let avatar_url: String
}

struct Repository: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
    let owner: Owner
}

struct RepositoryResponse: Codable {
    let items: [Repository]
}
