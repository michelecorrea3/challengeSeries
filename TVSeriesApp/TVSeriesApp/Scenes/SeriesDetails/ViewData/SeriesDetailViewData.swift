//
//  SeriesDetailViewData.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

struct SeriesDetailViewData {
    
    // MARK: - Properties

    var name: String
    var genre: String
    var dayTime: String
    var imageUrl: String
    var summary: String
    var model: SeriesDetailModel
    
    // MARK: - Initializers

    init(model: SeriesDetailModel) {
        self.model = model
        
        name = model.mainInfo.name
        genre = model.mainInfo.genres.joined(separator: " | ")
        dayTime = model.mainInfo.schedule.days.joined(separator: ", ") + " at " + model.mainInfo.schedule.time
        imageUrl = model.mainInfo.image?.medium ?? ""
        summary = model.mainInfo.summary
    }
    
    // MARK: - Public methods

    func seasonName(section: Int) -> String {
        if section == 0 {
            return ""
        }
        
        let season = model.episodesBySeason[section-1].0
        return String(format: "Season %d", season)
    }
    
    func episodeName(section: Int, index: Int) -> String {
        if section == 0 {
            return ""
        }

        return model.episodesBySeason[section-1].1[index].name
    }
}
