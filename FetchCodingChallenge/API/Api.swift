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
    /// <#Description#>
    /// - Returns: <#description#>
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
    
    /// <#Description#>
    /// - Parameter responseType: <#responseType description#>
    /// - Returns: <#description#>
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
