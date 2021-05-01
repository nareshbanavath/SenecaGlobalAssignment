//
//  UsersModel.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import Foundation

// MARK: - User
struct UsersModel: Codable {
    let page, perPage, total, totalPages: Int
    let users: [UserModel]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case users = "data"
    }

}

// MARK: - Datum
struct UserModel: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
