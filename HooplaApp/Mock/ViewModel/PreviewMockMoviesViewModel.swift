//
//  PreviewMockMoviesViewModel.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

class PreviewMockMoviesViewModel: MoviesViewModel {
    override init(networkManager: NetworkRepository = MockNetworkManager(mockDataType: .correctData),
                  imageCacheManager: ImageCacheRepository = MockImageCacheManager()) {
        super.init(networkManager: networkManager, imageCacheManager: imageCacheManager)
        self.movies = mockMovies
        self.moviesViewState = .success
    }
}
