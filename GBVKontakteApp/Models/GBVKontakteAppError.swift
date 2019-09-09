//
//  GBVKontakteAppError.swift
//  GBVKontakteApp
//
//  Created by Dmitry on 09/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

enum GBVKontakteAppError: Error {
//    case cityNotFound(message: String)
    case loginInputIncorrect(message: String)
}

extension GBVKontakteAppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
//        case .cityNotFound(let message):
//            return NSLocalizedString(message, comment: "")
        case .loginInputIncorrect(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
