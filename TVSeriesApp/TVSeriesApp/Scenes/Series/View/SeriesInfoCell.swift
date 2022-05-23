//
//  SeriesInfoCell.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import UIKit

class SeriesInfoCell: UITableViewCell {
    
    // MARK: - UI Properties

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var posterImageView: UIImageView?
    
    // MARK: - Overrides
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView?.image = nil
    }
    
    // MARK: - Public methods

    func setupCell(viewData: SeriesInfoCellViewData) {
        nameLabel?.text = viewData.title
        posterImageView?.downloadImageFrom(url: viewData.urlImage)
    }
}
