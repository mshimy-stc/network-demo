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
        if let log = prettyPrintedJSON(data) {
            print(log)
        }
        return data
    }

    private func prettyPrintedJSON(_ data: Data) -> String? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return String(data: data, encoding: .utf8)
        }
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
