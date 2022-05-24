//
//  SeriesDetailManager.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

protocol SeriesDetailManagerProtocol {
    typealias Success = ((SeriesDetailModel) -> Void)
    typealias Failure = ((SeriesError) -> Void)
    
    func loadAllDetails(id: Int, success: @escaping Success, failure: @escaping Failure)
}

class SeriesDetailManager: SeriesDetailManagerProtocol {
    
    // MARK: - Properties

    let service: SeriesDetailServiceProtocol
    
    // MARK: - Initializers

    init(service: SeriesDetailServiceProtocol = SeriesDetailService()) {
        self.service = service
    }
    
    // MARK: - Public methods

    func loadAllDetails(id: Int, success: @escaping Success, failure: @escaping Failure) {
        service.loadDetails(for: id) { details in

            self.service.loadEpisodes(for: details.id) { episodes in
                var episodesBySeason: [Int: [EpisodesBySeasonResponse]] = [:]
                let seasons = Set(episodes.map { $0.season })
                
                seasons.forEach {
                    episodesBySeason[$0] = []
                }
                
                episodes.forEach {
                    episodesBySeason[$0.season]?.append($0)
                }
                
                success(SeriesDetailModel(mainInfo: details,
                                          episodesBySeason: episodesBySeason.sorted(by: { $0.0 < $1.0 })))
                
            } failure: { (_) in
                failure(SeriesError.generic)
            }
            
        } failure: { (_) in
            failure(SeriesError.generic)
        }
    }
}
