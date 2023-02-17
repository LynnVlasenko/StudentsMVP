//
//  Student.swift
//  lesson16
//
//  Created by Алина Власенко on 16.02.2023.
//

import Foundation

struct Students: Codable {
    let students: [Student]
}

struct Student: Codable {
    let name: String
    let email: String
    let logo: URL
}
