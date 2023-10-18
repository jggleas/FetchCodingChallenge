//
//  MealsViewController.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import UIKit

final class MealDetailsViewController: UIViewController {
    // MARK: Variables
    private lazy var mealDetailsView = MealDetailsView(mealDetails: mealDetails, delegate: self)
    private lazy var mealDetailsViewModel = MealDetailsViewModel(mealDetails: mealDetails, delegate: self)
    
    private var mealDetails: MealDetails
    
    // MARK: Life Cycle Functions
    init(meal: Meal) {
        self.mealDetails = MealDetails(meal: meal)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = mealDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task { await mealDetailsViewModel.loadDetails() }
    }
}

// MARK: - Meal Details View Model Delegate Functions
extension MealDetailsViewController: MealDetailsViewModelDelegate {
    func mealDetailsFetched() {
        mealDetails = mealDetailsViewModel.mealDetails
        mealDetailsView.mealDetails = mealDetails
    }
    
    func loadingFailed(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            mealDetailsView.hide(.loading)
            mealDetailsView.showError(String(describing: error))
        }
    }
}

// MARK: - Meal Details View Delegate Functions
extension MealDetailsViewController: MealDetailsViewDelegate {
    func close() {
        navigationController?.popViewController(animated: true)
    }
}
