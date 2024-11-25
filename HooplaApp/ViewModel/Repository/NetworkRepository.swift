//
//  NetworkRepository.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

protocol NetworkRepository {
    func getMovies(url: URL) async throws -> PopularMoviesResponse
    func getMovieDetails(url: URL) async throws -> MovieDetail
}
