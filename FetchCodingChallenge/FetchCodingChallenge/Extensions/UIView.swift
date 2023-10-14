//
//  UIView.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/13/23.
//

import UIKit

extension UIView {
    func showLoading(withText text: String = "") {
        let loadingView = loadingView(withText: text)
        addSubview(loadingView)
        addConstraints([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func hideLoading() {
        for subview in subviews where subview.tag == .loadingViewTag {
            subview.removeFromSuperview()
        }
    }
    
    private func loadingView(withText text: String) -> UIView {
        let view = UIView()
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        let label = UILabel()
        
        // Setup views
        view.tag = .loadingViewTag
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.setCornerRadius(to: 12)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.color = .black
        loadingIndicator.startAnimating()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        view.addSubview(loadingIndicator)
        view.addSubview(label)
        
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
        
        return view
    }
    
    func setCornerRadius(to radius: CGFloat) {
        layer.cornerRadius = radius
        layer.cornerCurve = .continuous
        clipsToBounds = true
    }
}

private extension Int {
    static let loadingViewTag = 1000
}
