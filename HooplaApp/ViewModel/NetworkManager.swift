//
//  NetworkManager.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

class NetworkManager: NetworkRepository {
    private let urlSession: URLSession
    private let decoder: JSONDecoder

    // Default session configuration to ephemeral so nothing is cached or persisted
    init(urlSession: URLSession = URLSession(configuration: .ephemeral),
         decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    private func fetchData(with url: URL) async throws -> Data {
        let (data, response) = try await urlSession.data(from: url)

        // Validate response
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        // Check for successful HTTP status codes
        guard (200...299).contains(httpURLResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return data
    }

    func getMovies(url: URL) async throws -> PopularMoviesResponse {
        let data = try await fetchData(with: url)
        do {
            return try decoder.decode(PopularMoviesResponse.self, from: data)
        } catch {
            throw AppError.decodingError
        }
    }

    func getMovieDetails(url: URL) async throws -> MovieDetail {
        let data = try await fetchData(with: url)
        do {
            return try decoder.decode(MovieDetail.self, from: data)
        } catch {
            throw AppError.decodingError
        }
    }
}
