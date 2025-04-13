//
//  Date+Extensions.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 29.03.2025.
//

import Foundation

extension Date {
    func timeAgoSinceDate(_ date: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
        formatter.maximumUnitCount = 1
        
        let interval = self.timeIntervalSince(date)
        
        if let timeString = formatter.string(from: interval) {
            return "\(timeString) ago"
        } else {
            return "Just now"
        }
    }
}
