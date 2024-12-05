import XCTest
@testable import VKListAPILV

final class RepositoryViewModelTests: XCTestCase {
    var viewModel: RepositoryViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RepositoryViewModel()
    }
    
    func testSortByName() {
        
        let repo1 = Repository(id: 1, name: "B", description: nil, stargazers_count: 10, owner: Owner(avatar_url: ""))
        let repo2 = Repository(id: 2, name: "A", description: nil, stargazers_count: 20, owner: Owner(avatar_url: ""))
        viewModel.repositories = [repo1, repo2]
        
        viewModel.sortOption = .name
        
        XCTAssertEqual(viewModel.repositories[0].name, "A")
        XCTAssertEqual(viewModel.repositories[1].name, "B")
    }
    
    func testSortByDescriptionPresence() {

        let repo1 = Repository(id: 1, name: "Repo1", description: "Has description", stargazers_count: 10, owner: Owner(avatar_url: ""))
        let repo2 = Repository(id: 2, name: "Repo2", description: nil, stargazers_count: 20, owner: Owner(avatar_url: ""))
        viewModel.repositories = [repo1, repo2]
        
        viewModel.sortOption = .hasDescription
        
        XCTAssertEqual(viewModel.repositories[0].description, "Has description")
        XCTAssertNil(viewModel.repositories[1].description)
    }
}
