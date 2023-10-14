//
//  MealService.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

import Foundation

struct MealService {
    static func getMeal(category: String) async throws -> [Meal] {
        return try await MealApi.getMeal(category: category).requestData(MealResponse.self).meals
    }
    
    static func getDetails(for id: String) async throws -> MealDetails {
        guard let details = try await MealApi.getDetails(id: id).requestData(MealDetailsResponse.self).meals.first else {
            throw ApiError.noData
        }
        return details
    }
}
