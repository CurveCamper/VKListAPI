import Foundation

struct Repository: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
    let owner: Owner
}

struct Owner: Codable {
    let avatar_url: String
}

struct RepositoryResponse: Codable {
    let items: [Repository]
}
