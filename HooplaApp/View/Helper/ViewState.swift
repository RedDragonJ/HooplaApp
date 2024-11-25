//
//  ViewState.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case success
    case error(String)
}
