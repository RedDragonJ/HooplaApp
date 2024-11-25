//
//  URL+IsValid.swift
//  HooplaApp
//
//  Created by James Layton on 11/24/24.
//

import Foundation

extension URL {
    var isValid: Bool {
        guard let scheme = self.scheme, !scheme.isEmpty,
              let host = self.host, !host.isEmpty else {
            return false
        }
        return true
    }
}
