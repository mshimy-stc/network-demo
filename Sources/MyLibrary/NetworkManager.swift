//
//  NetworkManager.swift
//  MyLibrary
//
//  Created by Mohamed Shimy on 24/06/2025.
//

import Foundation



public class NetworkManager: NetworkManaging {

    public init() { }

    public func request(
        url: URL,
        method: String,
        headers: [String: String] = [:]
    ) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = method
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        let (data, response) = try await URLSession.shared.data(for: request)
        print(response)
        return data
    }

    public func request<T: Decodable>(
        url: URL,
        method: String,
        headers: [String: String] = [:]
    ) async throws -> T {
        let data = try await self.request(url: url, method: method, headers: headers)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
