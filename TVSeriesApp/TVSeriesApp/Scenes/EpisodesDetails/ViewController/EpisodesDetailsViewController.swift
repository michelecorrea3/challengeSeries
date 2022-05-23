//
//  EpisodesDetailsViewController.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import UIKit

class EpisodesDetailsViewController: UIViewController {
    
    // MARK: - UI Properties

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var seasonEpisodeLabel: UILabel?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    
    private let errorView = ErrorView()
    private let loadingView = LoadingView()

    // MARK: - Properties

    let viewModel = EpisodesDetailsViewModel()
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDataBinding()
        
        viewModel.loadEpisodeDetails()
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        tabBarController?.tabBar.backgroundColor = .lightGray
    }
    
    private func setupDataBinding() {
        viewModel.state.bind { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                break
            case .loading:
                self.loadingView.showIndicator(in: self.view)
            case .error:
                self.setupError()
            case .data:
                self.setupData()
            case .none:
                break
            }
        }
    }

    private func setupData() {
        loadingView.hideIndicator()
        
        guard let viewData = viewModel.data else { return }
        
        titleLabel?.text = viewData.name
        imageView?.downloadImageFrom(url: viewData.urlImage)
        seasonEpisodeLabel?.text = viewData.seasonEpisode
        
        let font = UIFont.systemFont(ofSize: 18)
        let modifiedFont = NSString(format:"<span style=\"font-family: \(font.fontName); font-size: \(font.pointSize)\">%@</span>" as NSString, viewData.summary)
        
        if let data = modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true),
           let attributedString = try? NSAttributedString(data: data, options: [
            .documentType: NSAttributedString.DocumentType.html
        ], documentAttributes: nil) {
            summaryLabel?.attributedText = attributedString
        }
    }
    
    private func setupError() {
        loadingView.hideIndicator()
        errorView.showError(in: view, delegate: self)
    }
}

// MARK: - Extensions

extension EpisodesDetailsViewController: ErrorViewDelegate {
    func tryAgain() {
        viewModel.loadEpisodeDetails()
    }
}
