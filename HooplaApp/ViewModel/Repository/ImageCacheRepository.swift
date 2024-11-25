//
//  ImageCacheRepository.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation
import UIKit

protocol ImageCacheRepository {
    func loadImage(key: String) -> UIImage?
    func saveImage(uiImage: UIImage, key: String)
    func fetchImage(url: URL) async throws -> UIImage?
    func clearCache()
}
