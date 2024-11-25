//
//  Constants.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

struct K {
    struct URL {
        static let baseURL = "https://midwest-tape.github.io/iOS-coding-challenge"
    }

    struct ImageCacheManager {
        static let domain = "com.imageCacheManager.lockQueue"
        static let path = "ImageCache"
    }

    struct InvalidState {
        static let domain = "com.sample.HooplaApp"
        static let code = 999
    }
}

enum MovieEndpoints {
    static func popularMovies(baseURL: URL) -> URL {
        return baseURL.appendingPathComponent("/popular.json")
    }

    static func movieDetail(baseURL: URL, titleID: String) -> URL {
        return baseURL.appendingPathComponent("/title/\(titleID).json")
    }
}
