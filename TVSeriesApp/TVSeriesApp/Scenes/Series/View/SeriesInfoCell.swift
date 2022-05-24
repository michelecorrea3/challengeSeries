//
//  SeriesInfoCell.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import UIKit

class SeriesInfoCell: UITableViewCell {
    
    // MARK: - UI Properties

    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var posterImageView: UIImageView?
    
    // MARK: - Properties

    private let viewModel = SeriesInfoCellViewModel()
    private var viewData: SeriesInfoCellViewData?

    // MARK: - Actions

    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let data = viewData else { return }
                
        if data.isFavorited == true {
            viewModel.deleteFavorite(viewData: data)
            viewData?.isFavorited = false
            favoriteButton?.setupNotFavoriteImage()
        } else {
            viewModel.saveFavorite(viewData: data)
            favoriteButton?.setupFavoriteImage()
            viewData?.isFavorited = true
        }
        
    }
    
    // MARK: - Overrides
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView?.image = nil
    }
    
    // MARK: - Public methods

    func setupCell(viewData: SeriesInfoCellViewData) {
        self.viewData = viewData
        
        nameLabel?.text = viewData.title
        posterImageView?.downloadImageFrom(url: viewData.urlImage)
        if viewData.isFavorited == true {
            favoriteButton?.setupFavoriteImage()
        } else {
            favoriteButton?.setupNotFavoriteImage()
        }
    }
}

private extension UIButton {
    func setupFavoriteImage() {
        setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    func setupNotFavoriteImage() {
        setBackgroundImage(UIImage(systemName: "star"), for: .normal)
    }
}
