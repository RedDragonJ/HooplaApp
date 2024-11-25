//
//  MovieCollection.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import SwiftUI

struct MovieCollection: View {
    @EnvironmentObject private var moviesVM: MoviesViewModel

    var body: some View {
        Group {
            switch moviesVM.moviesViewState {
            case .loading:
                ProgressView()
                    .foregroundStyle(.gray)
                    .scaleEffect(1.5)
            case .success:
                if moviesVM.movies.isEmpty {
                    EmptyStateView(message: "No Movies") {
                        getPopularMovies()
                    }
                } else {
                    ScrollView {
                        MovieCollectionGrid(movies: moviesVM.movies)
                            .padding(.horizontal)
                    }
                    .refreshable {
                        getPopularMovies()
                    }
                    .navigationTitle("Movies")
                }
            case .error(let errorMessage):
                ErrorView(errorMessage: errorMessage) {
                    getPopularMovies()
                }
            }
        }
        .onAppear {
            getPopularMovies()
        }
    }

    // MARK: - Helper
    
    private func getPopularMovies() {
        Task {
            await moviesVM.fetchMovies(K.URL.baseURL)
        }
    }
}

struct MovieCollectionGrid: View {
    @EnvironmentObject private var movieVM: MoviesViewModel
    let movies: [MovieSummary]

    var doubleGridLayout = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]

    var body: some View {
        LazyVGrid(columns: doubleGridLayout, spacing: 16) {
            ForEach(movies) { movie in
                NavigationLink(destination: MovieCollectionDetail(movieID: movie.id).environmentObject(movieVM)) {
                    MovieCollectionCell(movie: movie)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct MovieCollection_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = PreviewMockMoviesViewModel()

        Group {
            MovieCollection()
                .environmentObject(mockViewModel)
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)

            MovieCollection()
                .environmentObject(mockViewModel)
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
