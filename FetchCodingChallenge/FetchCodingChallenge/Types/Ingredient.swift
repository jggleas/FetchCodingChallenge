//
//  Ingredient.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

struct Ingredient: Decodable {
    /// The name of the ingredient.
    let name: String
    /// The measurement amount needed of the ingredient.
    let measurement: String
    /// `true` if the user owns enough of this ingredient to cover the given measurement, `false` otherwise.
    var owned: Bool = false
    
    /// Initialize an ingredient with the given parameters.
    /// - Parameters:
    ///   - name: The name of the ingredient.
    ///   - measurement: The measurement amount needed of the ingredient.
    init(name: String, measurement: String) {
        self.name = name
        self.measurement = measurement
    }
}
