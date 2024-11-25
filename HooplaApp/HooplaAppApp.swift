//
//  HooplaAppApp.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import SwiftUI

@main
struct HooplaAppApp: App {
    @StateObject private var moviesViewModel = MoviesViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieCollection()
                    .environmentObject(moviesViewModel)
            }
        }
    }
}
