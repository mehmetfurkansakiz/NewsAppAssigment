//
//  NetworkError.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 15.03.2025.
//

enum NetworkError: Error {
    case invalidRequest
    case decodingError
    case requestFailedWith(Int)
    case invalidResponse
    case customError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            "Invalid Request."
        case .decodingError:
            "Decoding Error."
        case .requestFailedWith(let statusCode):
            "Request Failed with status code: \(statusCode)."
        case .invalidResponse:
            "Invalid Response."
        case .customError(let error):
            error.localizedDescription
        }
    }
}
