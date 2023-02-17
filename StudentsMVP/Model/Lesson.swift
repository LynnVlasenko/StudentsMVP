//
//  Lesson.swift
//  lesson16
//
//  Created by Алина Власенко on 16.02.2023.
//

import Foundation

struct Lessons: Codable {
    let lessons: [Lesson]
}

struct Lesson: Codable {
    let name: String
    let hours: String
}
