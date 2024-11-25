//
//  MockMovie.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

// Correct data
let correctMoviesDictionary: [String: Any] = [
    "popular": [
        [
            "id": 1,
            "title": "The Grand Adventure",
            "author": "John Doe",
            "image_url": "https://via.placeholder.com/300x450?text=The+Grand+Adventure",
            "content_type": "movie"
        ],
        [
            "id": 2,
            "title": "Mystery of the Lost City",
            "author": "Jane Smith",
            "image_url": "https://via.placeholder.com/300x450?text=Mystery+of+the+Lost+City",
            "content_type": "audiobook"
        ]
    ]
]

// Malformed data
let malformedMoviesDictionary: [String: Any] = [
    "popular": [
        [
            // Missing "title"
            "id": 3,
            "author": "Emily Johnson",
            "image_url": "https://via.placeholder.com/300x450?text=Future+Horizons",
            "content_type": "comic"
        ],
        [
            "id": 4,
            "title": "The Shadow Hunter",
            // Missing "author"
            "image_url": "https://via.placeholder.com/300x450?text=The+Shadow+Hunter",
            "content_type": "tv"
        ],
        [
            "id": 5,
            "title": "Journey Beyond the Stars",
            "author": "Laura Wilson",
            // Invalid URL
            "image_url": "invalid_url",
            "content_type": "music"
        ],
        [
            "id": 6,
            "title": "Echoes of Time",
            "author": "Chris Taylor",
            "image_url": "https://via.placeholder.com/300x450?text=Echoes+of+Time"
            // Missing "content_type"
        ]
    ]
]

// Empty data case
let emptyMoviesDictionary: [String: Any] = [
    "popular": []
]
