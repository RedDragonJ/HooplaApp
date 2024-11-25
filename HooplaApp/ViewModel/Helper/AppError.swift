//
//  AppError.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

enum AppError: LocalizedError {
    case networkError
    case decodingError
    case urlError
    case customError(String)

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "There was a network issue. Please check your connection."
        case .decodingError:
            return "Failed to load data. Please try again later."
        case .urlError:
            return "The URL is invalid. Please contact support."
        case .customError(let message):
            return message
        }
    }
}
