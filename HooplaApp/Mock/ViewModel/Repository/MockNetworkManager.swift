//
//  MockNetworkManager.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

enum MockDataType {
    case correctData
    case malformedData
    case emptyData
    case urlError
    case customError
}

class MockNetworkManager: NetworkRepository {

    private let mockDataType: MockDataType

    init(mockDataType: MockDataType) {
        self.mockDataType = mockDataType
    }

    func getMovies(url: URL) async throws -> PopularMoviesResponse {
        let data: Data

        switch mockDataType {
        case .correctData:
            data = try JSONSerialization.data(withJSONObject: correctMoviesDictionary)

        case .malformedData:
            data = try JSONSerialization.data(withJSONObject: malformedMoviesDictionary)

        case .emptyData:
            data = try JSONSerialization.data(withJSONObject: emptyMoviesDictionary)

        case .urlError:
            throw URLError(.badURL, userInfo: [NSURLErrorFailingURLErrorKey: url])

        case .customError:
            throw NSError(domain: K.InvalidState.domain,
                          code: K.InvalidState.code,
                          userInfo: [NSLocalizedDescriptionKey: "Custom error occurred"])
        }

        return try JSONDecoder().decode(PopularMoviesResponse.self, from: data)
    }

    func getMovieDetails(url: URL) async throws -> MovieDetail {
        let data: Data

        switch mockDataType {
        case .correctData:
            data = try JSONSerialization.data(withJSONObject: mockMovieDetailDictionary)

        case .malformedData:
            data = try JSONSerialization.data(withJSONObject: malformedMovieDetailDictionary)

        case .emptyData:
            data = try JSONSerialization.data(withJSONObject: emptyMovieDetailDictionary)

        case .urlError:
            throw URLError(.badURL, userInfo: [NSURLErrorFailingURLErrorKey: url])

        case .customError:
            throw NSError(domain: K.InvalidState.domain,
                          code: K.InvalidState.code,
                          userInfo: [NSLocalizedDescriptionKey: "Custom error occurred"])
        }

        return try JSONDecoder().decode(MovieDetail.self, from: data)
    }
}
