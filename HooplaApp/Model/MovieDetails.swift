//
//  MovieDetails.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

struct MovieDetail: Codable {
    let title: TitleDetail?
}

struct TitleDetail: Codable {
    let id: Int
    let title: String?
    let author: String?
    let imageURL: URL?
    let contentType: ContentType?
    let synopsis: String?

    enum CodingKeys: String, CodingKey {
        case id, title, author
        case imageURL = "image_url"
        case contentType = "content_type"
        case synopsis
    }

    enum ContentType: String, Codable {
        case movie = "movie"
        case audiobook = "audiobook"
        case comic = "comic"
        case tv = "tv"
        case music = "music"
    }

    init(id: Int, title: String?, author: String?, imageURL: URL?, contentType: ContentType?, synopsis: String?) {
        self.id = id
        self.title = title
        self.author = author
        self.imageURL = imageURL
        self.contentType = contentType
        self.synopsis = synopsis
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        contentType = try container.decodeIfPresent(ContentType.self, forKey: .contentType)
        synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)

        // Directly assign valid URL or nil if invalid
        if let urlString = try container.decodeIfPresent(String.self, forKey: .imageURL),
           let url = URL(string: urlString), url.isValid {
            imageURL = url
        } else {
            imageURL = nil
        }
    }
}
