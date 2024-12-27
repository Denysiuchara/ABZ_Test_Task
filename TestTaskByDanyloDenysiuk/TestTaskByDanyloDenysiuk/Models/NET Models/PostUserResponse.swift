//
//  PostUserResponse.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import Foundation

struct PostUserResponse: Codable, Equatable {
    let success: Bool
    let userID: Int?
    let message: String

    enum CodingKeys: String, CodingKey {
        case success
        case userID = "user_id"
        case message
    }
}
