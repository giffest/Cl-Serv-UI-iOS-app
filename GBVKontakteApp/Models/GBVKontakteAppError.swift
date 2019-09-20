//
//  GBVKontakteAppError.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 14/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

enum GBVKontakteAppError: Error {
    case groupNotFound(message: String)
    case loginWebViewIncorrect(message: String)
}
extension GBVKontakteAppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .groupNotFound(let message):
            return NSLocalizedString(message, comment: "")
        case .loginWebViewIncorrect(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
