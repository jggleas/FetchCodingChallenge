//
//  MealDetailsView.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/12/23.
//

import UIKit
import Kingfisher

protocol MealDetailsViewDelegate: AnyObject {
    func close()
}

final class MealDetailsView: UIView {
    // MARK: Variables
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.tintColor = .black
        button.setCornerRadius(to: 18)
        button.setImage(.init(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.setImage(with: URL(string: mealDetails.imageUrl))
        imageView.setCornerRadius(to: 18)
        return imageView
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        let label = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = mealDetails.name
        view.addSubview(label)
        view.addConstraints([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        return view
    }()
    
    private lazy var detailsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = .init(top: 12, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        scrollView.addSubview(contentView)
        scrollView.addConstraints([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Directions"
        return label
    }()
    
    private lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Ingredients"
        return label
    }()
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    var mealDetails: MealDetails {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                updateData()
                hide(.loading)
            }
        }
    }
    
    private var delegate: MealDetailsViewDelegate?
    private var ingredientsTableViewHeightAnchor: NSLayoutConstraint?
    
    // MARK: Initialization
    init(mealDetails: MealDetails, delegate: MealDetailsViewDelegate) {
        self.mealDetails = mealDetails
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = .init(named: "mealDetailsBackground")
        
        // Add subviews
        addSubview(mealImageView)
        addSubview(titleView)
        addSubview(backButton)
        addSubview(detailsScrollView)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingredientsTableView)
        contentView.addSubview(instructionsTitleLabel)
        contentView.addSubview(instructionsLabel)
        
        // Setup constraints
        ingredientsTableViewHeightAnchor = ingredientsTableView.heightAnchor.constraint(equalToConstant: 0)
        addConstraints([
            mealImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mealImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            mealImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            mealImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            
            titleView.leadingAnchor.constraint(greaterThanOrEqualTo: mealImageView.leadingAnchor, constant: 12),
            titleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            titleView.bottomAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: -12),
            
            backButton.topAnchor.constraint(equalTo: mealImageView.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: mealImageView.leadingAnchor, constant: 12),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),
            
            detailsScrollView.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 12),
            detailsScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailsScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            detailsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ingredientsLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            ingredientsTableView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 12),
            ingredientsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            ingredientsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            ingredientsTableViewHeightAnchor!,
            
            instructionsTitleLabel.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor, constant: 24),
            instructionsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            instructionsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            instructionsLabel.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 12),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        showLoading(withText: "Loading \(mealDetails.name)")
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Private Action Functions
    private func updateData() {
        instructionsLabel.text = mealDetails.instructions.filter({ !$0.isSymbol })
        ingredientsTableView.reloadData()
    }
    
    @objc private func close() {
        delegate?.close()
    }
}

// MARK: - Table View Delegate Functions
extension MealDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .ingredientCellHeight
    }
}

// MARK: - Table View Data Source Functions
extension MealDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredientsTableViewHeightAnchor?.constant = CGFloat(mealDetails.ingredients.count) * .ingredientCellHeight
        return mealDetails.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = mealDetails.ingredients[indexPath.row]
        let cell = CustomTableViewCell(style: .labelSelection)
        cell.cellLabel.text = ingredient.measurement.contains(where: { $0.isNumber })
            ? "\(ingredient.measurement) \(ingredient.name)"
            : "\(ingredient.name) (\(ingredient.measurement))"
        cell.cellSelectionView.selected = ingredient.owned
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
        cell.cellSelectionView.selected.toggle()
        if cell.cellSelectionView.selected {
            DataManager.shared.createIngredient(
                name: mealDetails.ingredients[indexPath.row].name,
                measurement: mealDetails.ingredients[indexPath.row].measurement
            )
        } else {
            DataManager.shared.deleteIngredient(mealDetails.ingredients[indexPath.row])
        }
    }
}

// MARK: - Private Extension
extension CGFloat {
    static let ingredientCellHeight: CGFloat = 40
}
