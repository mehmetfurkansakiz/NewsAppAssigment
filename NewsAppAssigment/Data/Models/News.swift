//
//  News.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 14.03.2025.
//

import Foundation

struct News {
    var title: String?
    var article: String?
    var category: String?
    var createdAt: Date?
    var author: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case imageUrl = "image_url"
    }
}
