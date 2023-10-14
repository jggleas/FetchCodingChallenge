//
//  MealApi.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import Foundation

enum MealApi: Api {
    case getMeal(category: String)
    case getDetails(id: String)
    
    var method: HttpMethod { .GET }
    
    var host: String { "themealdb.com" }
    
    var path: String {
        switch self {
        case .getMeal:
            return "/api/json/v1/1/filter.php"
        case .getDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var params: [URLQueryItem]? {
        switch self {
        case .getMeal(let category):
            return [.init(name: "c", value: category)]
        case .getDetails(let id):
            return [.init(name: "i", value: id)]
        }
    }
    
    var body: Data? { nil }
}
