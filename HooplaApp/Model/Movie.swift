//
//  Movie.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

struct PopularMoviesResponse: Codable {
    let popular: [MovieSummary]
}

struct MovieSummary: Codable, Identifiable {
    let id: Int
    let title: String?
    let author: String?
    let contentType: ContentType?
    let imageURL: URL?

    enum ContentType: String, Codable {
        case movie
        case audiobook
        case comic
        case tv
        case music
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case imageURL = "image_url"
        case contentType = "content_type"
    }

    init(id: Int, title: String?, author: String?, contentType: ContentType?, imageURL: URL?) {
        self.id = id
        self.title = title
        self.author = author
        self.contentType = contentType
        self.imageURL = imageURL
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        contentType = try container.decodeIfPresent(ContentType.self, forKey: .contentType)

        // Directly assign valid URL or nil if invalid
        if let urlString = try container.decodeIfPresent(String.self, forKey: .imageURL),
           let url = URL(string: urlString), url.isValid {
            imageURL = url
        } else {
            imageURL = nil
        }
    }
}
