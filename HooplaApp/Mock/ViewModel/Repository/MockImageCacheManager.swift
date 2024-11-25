//
//  MockImageCacheManager.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation
import UIKit

enum MockImageCacheError: Error {
    case invalidURL
    case downloadFailed
}

class MockImageCacheManager: ImageCacheRepository {
    private var cache: [String: UIImage] = [:]
    private let queue = DispatchQueue(label: K.ImageCacheManager.domain, attributes: .concurrent)
    private let simulateError: Bool
    private let placeholderImage: UIImage

    init(simulateError: Bool = false,
         placeholderImage: UIImage = UIImage(systemName: "photo")!) {
        self.simulateError = simulateError
        self.placeholderImage = placeholderImage
    }

    func loadImage(key: String) -> UIImage? {
        // Simulate loading an image from disk cache
        return queue.sync { cache[key] }
    }

    func saveImage(uiImage: UIImage, key: String) {
        // Simulate saving an image to disk cache
        queue.async(flags: .barrier) {
            self.cache[key] = uiImage
        }
    }

    func clearCache() {
        // Simulate clearing the cache
        queue.async(flags: .barrier) {
            self.cache.removeAll()
        }
    }

    func fetchImage(url: URL) async throws -> UIImage? {
        let key = url.absoluteString

        // Check for existing cached image
        if let cachedImage = loadImage(key: key) {
            return cachedImage
        }

        // Simulate error if requested
        if simulateError {
            throw MockImageCacheError.downloadFailed
        }

        // Simulate downloading a new image and caching it
        saveImage(uiImage: placeholderImage, key: key)
        return placeholderImage
    }
}
