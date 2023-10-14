//
//  MealsViewController.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import UIKit

final class MealsViewController: UIViewController {
    // MARK: Variables
    private lazy var mealsView = MealsView(category: category, delegate: self)
    private lazy var mealsViewModel = MealsViewModel(category: category, delegate: self)
    
    private let category: String
    
    // MARK: Life Cycle Functions
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = mealsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        Task { await mealsViewModel.loadMeals() }
    }
}

// MARK: - Meals View Delegate Functions
extension MealsViewController: MealsViewDelegate {
    func selected(meal: Meal) {
        navigationController?.pushViewController(MealDetailsViewController(meal: meal), animated: true)
    }
}

// MARK: - Meals View Model Delegate Functions
extension MealsViewController: MealsViewModelDelegate {
    func mealsFetched() {
        mealsView.meals = mealsViewModel.meals.sorted(by: { $0.name < $1.name })
    }
    
    func loadingFailed(with error: Error) {
        // TODO: Show Error
        print("Loading failed with error: \(String(describing: error))")
    }
}
