//
//  ApiError.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidRequest
    case decodeFailed(_ error: Error)
    case noData
}
