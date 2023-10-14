//
//  MealsView.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import UIKit

protocol MealsViewDelegate: AnyObject {
    func selected(meal: Meal)
}

final class MealsView: UIView {
    // MARK: Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SnellRoundhand", size: 32)
        label.text = "Desserts Galore!"
        return label
    }()
    
    private lazy var mealsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layoutMargins = .zero
        tableView.separatorInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var meals = [Meal]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                mealsTableView.reloadData()
                hideLoading()
            }
        }
    }
    
    private let category: String
    private var delegate: MealsViewDelegate?
    
    // MARK: Initialization
    init(category: String, delegate: MealsViewDelegate) {
        self.category = category
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        // Add subviews
        addSubview(titleLabel)
        addSubview(mealsTableView)
        
        // Setup constraints
        addConstraints([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            mealsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            mealsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mealsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mealsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        showLoading(withText: "Loading \(category.capitalized)")
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Table View Delegate Functions
extension MealsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - Table View Data Source Functions
extension MealsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell(style: .labelImage)
        cell.cellLabel.text = meals[indexPath.row].name
        cell.cellImageView.kf.setImage(with: URL(string: meals[indexPath.row].imageUrl))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selected(meal: meals[indexPath.row])
    }
}
