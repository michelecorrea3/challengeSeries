//
//  SeriesDetailEpisodeCell.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import UIKit

class SeriesDetailEpisodeCell: UITableViewCell {
    
    // MARK: - UI Properties

    @IBOutlet weak var nameLabel: UILabel?
    
    // MARK: - Public methods

    func setupCell(viewData: SeriesDetailEpisodeViewData) {
        nameLabel?.text = viewData.name
    }
}
