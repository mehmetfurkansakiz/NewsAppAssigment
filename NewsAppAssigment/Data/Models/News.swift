//
//  News.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 14.03.2025.
//

struct News: Codable {
    var title: String?
    var article: String?
    var createdAt: String?
    var author: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case imageUrl = "image_url"
    }
}
