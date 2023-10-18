//
//  UIView.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

import UIKit

extension UIView {
    /// An enum for each view type and their respective tag.
    enum ViewType: Int {
        case loading = 1000
        case error = 1001
    }
    
    /// Show a loading view with the given text.
    /// - Parameter text: The text to show in the loading view.
    func showLoading(withText text: String = "") {
        let view = UIView()
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        let label = UILabel()
        
        // Setup views
        view.tag = ViewType.loading.rawValue
        view.setBorder(width: 1, color: .lightGray)
        view.setCornerRadius(to: 12)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.color = .black
        loadingIndicator.startAnimating()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        view.addSubview(loadingIndicator)
        view.addSubview(label)
        addSubview(view)
        
        // Setup constraints
        view.addConstraints([
            view.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width - 48),
            loadingIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        addConstraints([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.4)
        ])
    }
    
    /// Show an error view with the given text.
    /// - Note: By default, clicking the button will close the error view. There is no need to call `hide(.error)` within the `buttonAction` callback.
    /// - Parameters:
    ///   - error: The error to show.
    ///   - buttonAction: An optional callback that is performed when the button is clicked.
    func showError(_ error: String, buttonTitle: String = "Okay", buttonAction: (() -> Void)? = nil) {
        let view = UIView()
        let titleLabel = UILabel()
        let label = UILabel()
        let button = UIButton()
        
        // Setup views
        view.tag = ViewType.error.rawValue
        view.setBorder(width: 1, color: .lightGray)
        view.setCornerRadius(to: 12)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = "Error"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.text = error
        label.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(.init(string: buttonTitle, attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.black
        ]), for: .normal)
        button.addAction(.init(handler: { [weak self] (_) in
            self?.hide(.error)
            buttonAction?()
        }), for: .touchUpInside)
        button.setBorder(width: 1, color: .lightGray)
        button.setCornerRadius(to: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(label)
        view.addSubview(button)
        addSubview(view)
        
        // Setup constraints
        view.addConstraints([
            view.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width - 48),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            button.heightAnchor.constraint(equalToConstant: 36)
        ])
        addConstraints([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.4)
        ])
    }
    
    /// Hide the given view.
    /// - Parameter viewType: The type of the view to hide.
    func hide(_ viewType: ViewType) {
        for subview in subviews where subview.tag == viewType.rawValue {
            subview.removeFromSuperview()
        }
    }
    
    /// Set the view's corner radius.
    /// - Parameter radius: The radius of the corners.
    func setCornerRadius(to radius: CGFloat) {
        layer.cornerRadius = radius
        layer.cornerCurve = .continuous
        clipsToBounds = true
    }
    
    /// Set the view border to the given parameters.
    /// - Parameters:
    ///   - width: The width of the border.
    ///   - color: The color of the border.
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
