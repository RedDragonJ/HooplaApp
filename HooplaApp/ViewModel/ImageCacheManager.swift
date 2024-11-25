//
//  ImageCacheManager.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation
import UIKit

class ImageCacheManager: ImageCacheRepository {
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let queue = DispatchQueue(label: K.ImageCacheManager.domain, attributes: .concurrent)

    init() {
        let directory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = directory[0].appendingPathComponent(K.ImageCacheManager.path)

        // Create the directory if it does not exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }

    func loadImage(key: String) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        return queue.sync { // Allow multiple thread to read the image file simultaneously
            guard fileManager.fileExists(atPath: fileURL.path),
                  let data = try? Data(contentsOf: fileURL) else {
                return nil
            }
            return UIImage(data: data)
        }
    }

    func saveImage(uiImage: UIImage, key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        queue.async(flags: .barrier) { // Use a barrier flag to ensure writing to disk operation happen one at time
            guard let data = uiImage.pngData() else { return }
            do {
                try data.write(to: fileURL, options: .atomic)
            } catch {
                // Log and fail silently
                print("Failed to save image to disk: \(error.localizedDescription)")
            }
        }
    }

    func fetchImage(url: URL) async throws -> UIImage? {
        let key = url.absoluteString.hashValue.description

        // Try loading from cache first
        if let cachedImage = loadImage(key: key) {
            return cachedImage
        }

        // Download image
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                // Log and fail silently
                print("Failed to decode image from data")
                return nil
            }
            saveImage(uiImage: image, key: key)
            return image
        } catch {
            // Log and fail silently
            print("Failed to fetch image: \(error.localizedDescription)")
            return nil
        }
    }

    func clearCache() {
        queue.async(flags: .barrier) { // Waits for other operation such as write in this case to finish, prevent race condition
            do {
                let fileURLs = try self.fileManager.contentsOfDirectory(at: self.cacheDirectory, includingPropertiesForKeys: nil)
                for fileURL in fileURLs {
                    try self.fileManager.removeItem(at: fileURL)
                }
            } catch {
                print("Failed to clear cache: \(error.localizedDescription)")
            }
        }
    }
}
