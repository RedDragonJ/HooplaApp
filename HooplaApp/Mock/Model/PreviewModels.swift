//
//  PreviewModels.swift
//  HooplaApp
//
//  Created by James Layton on 11/24/24.
//

import Foundation

let mockMovieDetails = TitleDetail(
    id: 1,
    title: "The Grand Adventure",
    author: "John Doe",
    imageURL: URL(string: "https://picsum.photos/300/450")!,
    contentType: .movie,
    synopsis: "Join a brave explorer on a thrilling quest through uncharted lands to uncover hidden treasures and ancient secrets."
)

let mockMovies = [
    MovieSummary(id: 1, title: "The Grand Adventure", author: "John Doe", contentType: .movie, imageURL: URL(string: "https://picsum.photos/300/450")),
    MovieSummary(id: 2, title: "Mystery of the Lost City", author: "Jane Smith", contentType: .audiobook, imageURL: URL(string: "https://picsum.photos/300/450")),
    MovieSummary(id: 3, title: "Future Horizons", author: "Emily Johnson", contentType: .comic, imageURL: URL(string: "https://picsum.photos/300/450"))
]
