//
//  Meal.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

import Foundation

class Meal: Decodable {
    /// The name of the meal.
    let name: String
    /// The url to an image of the meal.
    let imageUrl: String
    /// The id of the meal.
    let id: String
    
    enum CodingKeys: CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .strMeal)
        imageUrl = try container.decode(String.self, forKey: .strMealThumb)
        id = try container.decode(String.self, forKey: .idMeal)
    }
    
    /// Initialize a meal with the given parameters.
    /// - Parameters:
    ///   - name: The name of the meal.
    ///   - imageUrl: The url to an image of the meal.
    ///   - id: The id of the meal.
    init(name: String, imageUrl: String, id: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
}

/// The response object for the data the API returns when retrieving a list of meals.
struct MealResponse: Decodable {
    let meals: [Meal]
}
