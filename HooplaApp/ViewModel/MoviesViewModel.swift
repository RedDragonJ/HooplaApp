//
//  MoviesViewModel.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation
import UIKit

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: [MovieSummary] = []
    @Published var titleDetails: TitleDetail?

    @Published var moviesViewState: ViewState = .loading
    @Published var movieDetailsViewState: ViewState = .loading

    private let networkManager: NetworkRepository
    private let imageCacheManager: ImageCacheRepository

    init(networkManager: NetworkRepository = NetworkManager(),
         imageCacheManager: ImageCacheRepository = ImageCacheManager()) {
        self.networkManager = networkManager
        self.imageCacheManager = imageCacheManager
    }

    func fetchMovies(_ baseURLString: String) async {
        moviesViewState = .loading

        guard let baseURL = URL(string: baseURLString) else {
            moviesViewState = .error(AppError.urlError.localizedDescription)
            return
        }

        do {
            let url = MovieEndpoints.popularMovies(baseURL: baseURL)
            let newMoviesResponse = try await networkManager.getMovies(url: url)
            self.movies = newMoviesResponse.popular
            moviesViewState = .success
        } catch {
            moviesViewState = .error(handleError(error))
        }
    }

    func fetchMovieDetails(_ baseURLString: String, titleID: Int) async {
        movieDetailsViewState = .loading

        guard let baseURL = URL(string: baseURLString) else {
            movieDetailsViewState = .error(AppError.urlError.localizedDescription)
            return
        }

        do {
            let url = MovieEndpoints.movieDetail(baseURL: baseURL, titleID: String(titleID))
            let movieDetail = try await networkManager.getMovieDetails(url: url)
            self.titleDetails = movieDetail.title
            movieDetailsViewState = .success
        } catch {
            movieDetailsViewState = .error(handleError(error))
        }
    }

    func getImage(_ url: URL?) async -> UIImage? {
        guard let url else {
            print(AppError.urlError.localizedDescription)
            return nil
        }

        do {
            return try await imageCacheManager.fetchImage(url: url)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    private func handleError(_ error: Error) -> String {
        switch error {
        case is URLError:
            return AppError.networkError.localizedDescription
        case is DecodingError:
            return AppError.decodingError.localizedDescription
        default:
            return AppError.customError("An unexpected error occurred").localizedDescription
        }
    }
}
