//
//  LoadingView.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import SwiftUI

struct LoadingView: View {

    let spinnerColor = Color.gray

    var body: some View {
        ProgressView()
            .foregroundStyle(spinnerColor)
    }
}
