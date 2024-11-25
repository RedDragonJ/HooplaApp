//
//  MoviesViewModelTests.swift
//  HooplaAppTests
//
//  Created by James Layton on 11/24/24.
//

import XCTest

@MainActor
final class MoviesViewModelTests: XCTestCase {

    // MARK: - Tests for fetchMovies

    func testFetchMoviesSuccess() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .correctData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovies("https://mockurl.com")

        // Then
        XCTAssertEqual(viewModel.moviesViewState, .success)
        XCTAssertFalse(viewModel.movies.isEmpty)
        XCTAssertEqual(viewModel.movies.count, 2)
    }

    func testFetchMoviesMalformedData() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .malformedData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovies("https://mockurl.com")

        // Then
        XCTAssertEqual(viewModel.moviesViewState, .success)
        XCTAssertEqual(viewModel.movies.count, 4)

        let thirdMovie = viewModel.movies[2]
        XCTAssertEqual(thirdMovie.id, 5)
        XCTAssertEqual(thirdMovie.title, "Journey Beyond the Stars")
        XCTAssertEqual(thirdMovie.author, "Laura Wilson")
        XCTAssertNil(thirdMovie.imageURL)
    }

    func testFetchMoviesEmptyData() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .emptyData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovies("https://mockurl.com")

        // Then
        XCTAssertEqual(viewModel.moviesViewState, .success)
        XCTAssertTrue(viewModel.movies.isEmpty)
    }

    func testFetchMoviesURLError() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .urlError)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovies("https://mockurl.com")

        // Then
        if case .error(let errorMessage) = viewModel.moviesViewState {
            XCTAssertEqual(errorMessage, AppError.networkError.localizedDescription)
        } else {
            XCTFail("Expected moviesViewState to be .error with a specific message")
        }
    }

    // MARK: - Tests for fetchMovieDetails

    func testFetchMovieDetailsSuccess() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .correctData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovieDetails("https://mockurl.com", titleID: 1)

        // Then
        XCTAssertEqual(viewModel.movieDetailsViewState, .success)
        XCTAssertNotNil(viewModel.titleDetails)
        XCTAssertEqual(viewModel.titleDetails?.id, 1)
        XCTAssertEqual(viewModel.titleDetails?.title, "The Grand Adventure")
        XCTAssertEqual(viewModel.titleDetails?.author, "John Doe")
        XCTAssertEqual(viewModel.titleDetails?.contentType, .movie)
        XCTAssertEqual(viewModel.titleDetails?.imageURL, URL(string: "https://picsum.photos/300/450"))
        XCTAssertEqual(viewModel.titleDetails?.synopsis, "Join a brave explorer on a thrilling quest through uncharted lands to uncover hidden treasures and ancient secrets.")
    }

    func testFetchMovieDetailsMalformedData() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .malformedData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovieDetails("https://mockurl.com", titleID: 1)

        // Then
        if case .error(let errorMessage) = viewModel.movieDetailsViewState {
            XCTAssertEqual(errorMessage, AppError.decodingError.localizedDescription)
        } else {
            XCTFail("Expected movieDetailsViewState to be .error with a decoding error message")
        }
        XCTAssertNil(viewModel.titleDetails)
    }

    func testFetchMovieDetailsEmptyData() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .emptyData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovieDetails("https://mockurl.com", titleID: 1)

        // Then
        if case .error(let errorMessage) = viewModel.movieDetailsViewState {
            XCTAssertEqual(errorMessage, AppError.decodingError.localizedDescription)
        } else {
            XCTFail("Expected movieDetailsViewState to be .error with a decoding error message")
        }
        XCTAssertNil(viewModel.titleDetails)
    }

    func testFetchMovieDetailsURLError() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .urlError)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        // When
        await viewModel.fetchMovieDetails("https://mockurl.com", titleID: 1)

        // Then
        if case .error(let errorMessage) = viewModel.movieDetailsViewState {
            XCTAssertEqual(errorMessage, AppError.networkError.localizedDescription)
        } else {
            XCTFail("Expected movieDetailsViewState to be .error with a network error message")
        }
        XCTAssertNil(viewModel.titleDetails)
    }

    // MARK: - Tests for getImage

    func testGetImageFromCache() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .correctData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        let url = URL(string: "https://example.com/image.png")!
        let mockImage = UIImage(systemName: "photo")!
        mockImageCacheManager.saveImage(uiImage: mockImage, key: url.absoluteString)

        // When
        let fetchedImage = await viewModel.getImage(url)

        // Then
        XCTAssertEqual(fetchedImage, mockImage)
    }

    func testGetImageNewDownload() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .correctData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        let url = URL(string: "https://example.com/image.png")!

        // When
        let fetchedImage = await viewModel.getImage(url)

        // Then
        XCTAssertNotNil(fetchedImage)
    }

    func testGetImageInvalidURL() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager(mockDataType: .correctData)
        let mockImageCacheManager = MockImageCacheManager()
        let viewModel = MoviesViewModel(networkManager: mockNetworkManager, imageCacheManager: mockImageCacheManager)

        let invalidURL: URL? = nil

        // When
        let fetchedImage = await viewModel.getImage(invalidURL)

        // Then
        XCTAssertNil(fetchedImage)
    }
}
