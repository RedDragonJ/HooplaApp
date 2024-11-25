//
//  MockMovieDetails.swift
//  HooplaApp
//
//  Created by James Layton on 11/24/24.
//

import Foundation

// Correct data
let mockMovieDetailDictionary: [String: Any] = ["title": [
    "id": 1,
    "title": "The Grand Adventure",
    "author": "John Doe",
    "image_url": "https://picsum.photos/300/450",
    "content_type": "movie",
    "synopsis": "Join a brave explorer on a thrilling quest through uncharted lands to uncover hidden treasures and ancient secrets."
    ]
]

// Malformed data
let malformedMovieDetailDictionary: [String: Any] = ["title": [
    "id": 1, // Keep ID valid
    "author": ["nested": "unexpected_structure"], // Invalid type for author
    "image_url": 12345, // Invalid type for image_url
    "content_type": "invalid_content_type", // Value not matching enum
    "synopsis": true // Invalid type for synopsis
]
]

// Empty data case
let emptyMovieDetailDictionary: [String: Any] = ["title": []]
