//
//  MockNetworkManger.swift
//  MyLibrary
//
//  Created by Mohamed Shimy on 24/06/2025.
//

import Foundation
import MyLibrary

class MockGitHubNetworkManger: NetworkManaging {

    func request(
        url: URL,
        method: String,
        headers: [String : String]
    ) async throws -> Data {
        guard url.absoluteString.contains("api.github.com/users") else {
            return Data()
        }

        guard let path = Bundle.module.path(
            forResource: "users",
            ofType: "json"
        ) else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }

    func request<T>(
        url: URL,
        method: String,
        headers: [String : String]
    ) async throws -> T where T : Decodable {
        let data = try await self.request(url: url, method: method, headers: headers)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
