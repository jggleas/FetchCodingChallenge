//
//  MealsViewModel.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

protocol MealDetailsViewModelDelegate: AnyObject {
    func mealDetailsFetched()
    func loadingFailed(with error: Error)
}

final class MealDetailsViewModel {
    // MARK: Variables
    var mealDetails: MealDetails
    private var delegate: MealDetailsViewModelDelegate?
    
    // MARK: Initialization
    init(mealDetails: MealDetails, delegate: MealDetailsViewModelDelegate) {
        self.mealDetails = mealDetails
        self.delegate = delegate
    }
    
    // MARK: Function
    func loadDetails() async {
        do {
            mealDetails = try await MealService.getDetails(for: mealDetails.id)
            delegate?.mealDetailsFetched()
        } catch {
            delegate?.loadingFailed(with: error)
        }
    }
}
