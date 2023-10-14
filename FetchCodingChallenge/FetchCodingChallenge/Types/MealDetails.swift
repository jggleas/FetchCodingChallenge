//
//  MealDetails.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

import Foundation

final class MealDetails: Meal {
    /// The category of the meal.
    let category: String
    /// The instructions to make the meal.
    let instructions: String
    /// The ingredients needed to make the meal.
    var ingredients = [Ingredient]()
    
    private enum CodingKeys: CodingKey {
        case strCategory
        case strInstructions
        case strIngredient1
        case strMeasure1
        case strIngredient2
        case strMeasure2
        case strIngredient3
        case strMeasure3
        case strIngredient4
        case strMeasure4
        case strIngredient5
        case strMeasure5
        case strIngredient6
        case strMeasure6
        case strIngredient7
        case strMeasure7
        case strIngredient8
        case strMeasure8
        case strIngredient9
        case strMeasure9
        case strIngredient10
        case strMeasure10
        case strIngredient11
        case strMeasure11
        case strIngredient12
        case strMeasure12
        case strIngredient13
        case strMeasure13
        case strIngredient14
        case strMeasure14
        case strIngredient15
        case strMeasure15
        case strIngredient16
        case strMeasure16
        case strIngredient17
        case strMeasure17
        case strIngredient18
        case strMeasure18
        case strIngredient19
        case strMeasure19
        case strIngredient20
        case strMeasure20
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decode(String.self, forKey: .strCategory)
        instructions = try container.decode(String.self, forKey: .strInstructions)
        
        for i in 1..<21 {
            let name = try container.decode(String.self, forKey: CodingKeys(stringValue: "strIngredient\(i)")!)
                .trimmingCharacters(in: .whitespaces)
            let measurement = try container.decode(String.self, forKey: CodingKeys(stringValue: "strMeasure\(i)")!)
                .trimmingCharacters(in: .whitespaces)
            guard !name.isEmpty else { break }
            ingredients.append(.init(name: name, measurement: measurement))
        }
        
        try super.init(from: decoder)
    }
    
    /// Initialize the meal details with the given parameters.
    /// - Parameters:
    ///   - meal: The meal being made.
    ///   - category: The category of the meal.
    ///   - instructions: The instructions to make the meal.
    ///   - ingredients: The ingredients needed to make the meal.
    init(meal: Meal, category: String = "", instructions: String = "", ingredients: [Ingredient] = []) {
        self.category = category
        self.instructions = instructions
        self.ingredients = ingredients
        super.init(name: meal.name, imageUrl: meal.imageUrl, id: meal.id)
    }
}

/// The response object for the data the API returns when retrieving a meal's details.
struct MealDetailsResponse: Decodable {
    let meals: [MealDetails]
}
