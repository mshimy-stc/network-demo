//
//  NetworkManaging.swift
//  MyLibrary
//
//  Created by Mohamed Shimy on 24/06/2025.
//

import Foundation

public protocol NetworkManaging {

    func request(
        url: URL,
        method: String,
        headers: [String: String]
    ) async throws -> Data

    func request<T: Decodable>(
        url: URL,
        method: String,
        headers: [String: String]
    ) async throws -> T
}
