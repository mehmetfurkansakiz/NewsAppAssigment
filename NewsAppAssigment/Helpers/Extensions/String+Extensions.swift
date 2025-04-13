//
//  String+Extensions.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

extension String {
    var username: String {
        return self.components(separatedBy: "@").first ?? self
    }
}
