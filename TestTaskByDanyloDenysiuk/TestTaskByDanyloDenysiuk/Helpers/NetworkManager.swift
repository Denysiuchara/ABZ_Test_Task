//
//  NetworkManager.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import Foundation

final class NetworkManager {
    
    private let session: URLSession
    private let endpoint: String = "https://frontend-test-assignment-api.abz.agency/api/v1"
    
    init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    
    func getUsers(page: Int, count: Int) async throws -> [User] {
        guard var components = URLComponents(string: "\(endpoint)/\(Path.users.rawValue)") else {
            throw URLError(.badURL)
        }
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "count", value: "\(count)")
        ]
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(UserResponse.self, from: data)
        return result.users
    }
    
    
    func getPositions() async throws -> [Position] {
        guard let url = urlContstructor(for: .positions) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(PositionResponse.self, from: data)
        return result.positions
    }
    
    
    func getToken() async throws -> String {
        guard let url = urlContstructor(for: .token) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(Token.self, from: data)
        return result.token
    }
    
    func postUser(token: String, user: NewUser) async throws -> PostUserResponse {
        guard let url = urlContstructor(for: .users) else {
            throw URLError(.badURL)
        }
        
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(token, forHTTPHeaderField: "Token")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = user.createMultipartFormData(boundary: boundary)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
            print("User registered successfully")
        } else {
            print("Failed to register user")
        }
        
        return try JSONDecoder().decode(PostUserResponse.self, from: data)
    }
}

extension NetworkManager {
    func urlContstructor(for path: Path) -> URL? {
        return URL(string: "\(endpoint)/\(path.rawValue)")
    }
}

extension NetworkManager {
    enum Path: String {
        case users
        case positions
        case token
    }
}
