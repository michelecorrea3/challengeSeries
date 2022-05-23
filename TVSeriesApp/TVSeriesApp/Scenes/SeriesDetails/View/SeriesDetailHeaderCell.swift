//
//  SeriesDetailHeaderCell.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import UIKit

class SeriesDetailHeaderCell: UITableViewCell {
    
    // MARK: - UI Properties

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var genreLabel: UILabel?
    @IBOutlet weak var daysTimeLabel: UILabel?
    @IBOutlet weak var summaryLabel: UILabel?
    
    // MARK: - Public methods

    func setupDetails(viewData: SeriesDetailViewData) {
        titleLabel?.text = viewData.name
        posterImageView?.downloadImageFrom(url: viewData.imageUrl)
        daysTimeLabel?.text = viewData.dayTime
        genreLabel?.text = viewData.genre

        let font = UIFont.systemFont(ofSize: 18)
        let modifiedFont = NSString(format:"<span style=\"font-family: \(font.fontName); font-size: \(font.pointSize)\">%@</span>" as NSString, viewData.summary)
        
        if let data = modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true),
           let attributedString = try? NSAttributedString(data: data, options: [
            .documentType: NSAttributedString.DocumentType.html
        ], documentAttributes: nil) {
            summaryLabel?.attributedText = attributedString
        }
    }
}
