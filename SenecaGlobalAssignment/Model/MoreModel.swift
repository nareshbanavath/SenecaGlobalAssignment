//
//  MoreModel.swift
//  SenecaGlobalAssignment
//
//  Created by naresh banavath on 30/04/21.
//

import Foundation
// MARK: - MoreStructElement
struct MoreStructElement: Codable {
    let id: Int?
    let name, username, email: String?
  var address: AddressStruct?
    let phone, website: String?
    var company: CompanyStruct?
}

// MARK: - Address
struct AddressStruct: Codable {
    let street, suite, city, zipcode: String
    var geo: GeoStruct?
}

// MARK: - Geo
struct GeoStruct: Codable {
    let lat, lng: String
}

// MARK: - Company
struct CompanyStruct: Codable {
    let name, catchPhrase, bs: String
}

typealias MoreStruct = [MoreStructElement]
