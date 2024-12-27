
import Foundation
import SwiftUI


// MARK: - User Response
struct UserResponse: Decodable {
    let success: Bool
    let totalPages,
        totalUsers,
        count,
        page: Int
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case success
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case count,
             page,
             users
    }
}

// MARK: - User
struct User: Decodable, Identifiable {
    let id: Int
    let name,
        email,
        phone,
        position: String
    let positionID,
        registrationTimestamp: Int
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             email,
             phone,
             position
        case positionID = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}


// MARK: - New User
struct NewUser {
    let name: String
    let email: String
    let phone: String
    let positionId: Int
    let photo: Data
    
    func createMultipartFormData(boundary: String) -> Data {
        var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(name)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"email\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(email)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"phone\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(phone.validPhoneField)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"position_id\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(positionId)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(photo)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}
