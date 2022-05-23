//
//  ErrorView.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

// <a href="https://www.flaticon.com/free-icons/no-results" title="no results icons">No results icons created by Kalashnyk - Flaticon</a>

import UIKit

protocol ErrorViewDelegate: class {
    func tryAgain()
}

class ErrorView: UIView {
    
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
        label.text = "Sorry, an error occurred!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "error")
        return imageView
    }()
    
    let tryAgainButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("try again", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        return button
    }()
    
    // MARK: - Properties

    weak var delegate: ErrorViewDelegate?
    
    // MARK: - Actions
    
    @objc func tryAgainAction() {
        delegate?.tryAgain()
        contentView.removeFromSuperview()
    }
    
    // MARK: - Public methods

    func showError(in view: UIView, delegate: ErrorViewDelegate) {
        self.delegate = delegate
        
        buildView(with: view)
        setupConstraints(for: view)
    }
    
    // MARK: - Private methods
    
    private func buildView(with view: UIView) {
        contentView.backgroundColor = .white
        
        tryAgainButton.addTarget(self, action: #selector(tryAgainAction), for: .touchUpInside)

        titleContainer.addSubview(titleLabel)
        contentView.addSubview(titleContainer)
        contentView.addSubview(tryAgainButton)
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
            
            tryAgainButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            tryAgainButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 50),
            tryAgainButton.widthAnchor.constraint(equalToConstant: 130),

            contentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

}
