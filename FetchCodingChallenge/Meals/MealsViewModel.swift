//
//  MealsViewModel.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

protocol MealsViewModelDelegate: AnyObject {
    func mealsFetched()
    func loadingFailed(with error: Error)
}

final class MealsViewModel {
    // MARK: Variables
    var meals = [Meal]()
    private let category: String
    private var delegate: MealsViewModelDelegate?
    
    // MARK: Initialization
    init(category: String, delegate: MealsViewModelDelegate) {
        self.category = category
        self.delegate = delegate
    }
    
    // MARK: Functions
    func loadMeals() async {
        do {
            meals = try await MealService.getMeal(category: category)
            delegate?.mealsFetched()
        } catch {
            delegate?.loadingFailed(with: error)
        }
    }
}
