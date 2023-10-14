//
//  Api.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import Foundation

// MARK: Api
protocol Api {
    var method: HttpMethod { get }
    var host: String { get }
    var path: String { get }
    var params: [URLQueryItem]? { get }
    var body: Data? { get }
}

// MARK: Api Functions (Extension)
extension Api {
    /// Create a network request.
    /// - Note: Should generally only be consumed via `requestData(_:)`, unless response body is irrelevant.
    /// - Returns: The response data from the network request.
    func request() async throws -> Data {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = params
        
        guard let url = components.url else { throw ApiError.invalidUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        return try await URLSession.shared.data(for: request).0
    }
    
    /// Create a network request with a pre-defined returned data type.
    /// - Parameter responseType: The response data type returned from the API.
    /// - Returns: The API response, decoded to the given response type.
    func requestData<T: Decodable>(_ responseType: T.Type) async throws -> T {
        let data = try await request()
        do {
            return try JSONDecoder().decode(responseType, from: data)
        } catch let error {
            throw ApiError.decodeFailed(error)
        }
    }
}

// MARK: HttpMethod
enum HttpMethod: String {
    case GET
    case POST
}
