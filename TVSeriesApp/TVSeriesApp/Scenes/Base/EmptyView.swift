//
//  EmptyView.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 24/05/22.
//

// <a href="https://www.flaticon.com/free-icons/empty" title="empty icons">Empty icons created by smashingstocks - Flaticon</a>

import UIKit

class EmptyView: UIView {
    
    // MARK: - UI Properties
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    } ()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You haven't favorited any series yet!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "empty")
        return imageView
    }()
    
    // MARK: - Public methods

    func showEmptyView(in view: UIView) {
        buildView(with: view)
        setupConstraints(for: view)
    }
    
    func hideEmptyView() {
        contentView.removeFromSuperview()
    }
    
    // MARK: - Private methods
    
    private func buildView(with view: UIView) {
        contentView.backgroundColor = .white
        
        titleContainer.addSubview(titleLabel)
        contentView.addSubview(titleContainer)
        contentView.addSubview(imageView)
        
        view.addSubview(contentView)
    }
    
    private func setupConstraints(for view: UIView) {
        NSLayoutConstraint.activate([
            titleContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -20),

            imageView.topAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),

            contentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

}
