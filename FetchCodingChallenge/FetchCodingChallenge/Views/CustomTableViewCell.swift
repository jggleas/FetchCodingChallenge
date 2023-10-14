//
//  CustomTableViewCell.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

import UIKit

/// List of styles for the ``CustomTableViewCell``.
enum CustomStyle {
    /// The style containing a selection view checkbox and a label, both left-aligned.
    case labelSelection
    /// The style containing a left-aligned label and a right-aligned image.
    case labelImage
}

class CustomTableViewCell: UITableViewCell {
    // MARK: Variables
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var cellSelectionView: SelectionView = {
        let view = SelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static let identifier = "CustomTableViewCell"
    
    // MARK: Initialization
    init(style: CustomStyle = .labelImage) {
        super.init(style: .default, reuseIdentifier: CustomTableViewCell.identifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        switch style {
        case .labelSelection:
            setupLabelSelectionStyle()
        case .labelImage:
            setupLabelImageStyle()
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Private Setup Functions
    private func setupLabelSelectionStyle() {
        contentView.addSubview(cellSelectionView)
        contentView.addSubview(cellLabel)
        contentView.addConstraints([
            cellSelectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellSelectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellSelectionView.widthAnchor.constraint(equalToConstant: 16),
            cellSelectionView.heightAnchor.constraint(equalToConstant: 16),
            
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellSelectionView.trailingAnchor, constant: 8),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupLabelImageStyle() {
        contentView.addSubview(cellLabel)
        contentView.addSubview(cellImageView)
        contentView.addConstraints([
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: cellLabel.trailingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor, multiplier: 1)
        ])
    }
}
