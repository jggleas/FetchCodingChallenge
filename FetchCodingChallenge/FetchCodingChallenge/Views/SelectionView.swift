//
//  SelectionView.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

import UIKit

class SelectionView: UIView {
    // MARK: Variables
    private lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "checkmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    var selected: Bool = false {
        willSet { selectedImageView.isHidden = !newValue }
    }
    
    // MARK: Initialization
    init(tintColor: UIColor = .black) {
        super.init(frame: .zero)
        
        layer.borderWidth = 1
        layer.borderColor = tintColor.cgColor
        
        addSubview(selectedImageView)
        addConstraints([
            selectedImageView.topAnchor.constraint(equalTo: topAnchor),
            selectedImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
