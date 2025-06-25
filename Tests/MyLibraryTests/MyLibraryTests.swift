import XCTest
import MyLibrary

final class MyLibraryTests: XCTestCase {

    private var manager: NetworkManaging!

    override func setUp() {
        super.setUp()

        manager = NetworkManager()
    }

    override func tearDown() {
        super.tearDown()

        manager = nil
    }

    func testGetUsers() async throws {
       let url = URL(string: "https://api.github.com/users")!

        let user: [User] = try await manager.request(
            url: url,
            method: "GET",
            headers: ["Content-Type": "application/json"]
        )
        print(user.count)
        XCTAssertFalse(user.isEmpty, "users list is empty")
    }

    func testGetUser() async throws {
        let url = URL(string: "https://api.github.com/users/octocat")!

        let user: User = try await manager.request(
            url: url,
            method: "GET",
            headers: ["Content-Type": "application/json"]
        )

        XCTAssertEqual(user.login, "octocat")
    }
}

struct User: Decodable {

    let id: Int
    let login: String
}
