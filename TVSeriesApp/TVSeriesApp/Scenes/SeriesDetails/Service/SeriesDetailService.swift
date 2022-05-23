//
//  SeriesDetailService.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

protocol SeriesDetailServiceProtocol {
    typealias SuccessDetails = ((SeriesDetailResponse) -> Void)
    typealias SuccessEpisodes = (([EpisodesBySeasonResponse]) -> Void)
    typealias Failure = ((SeriesError) -> Void)
    
    func loadDetails(for seriesId: Int, success: @escaping SuccessDetails, failure: @escaping Failure)
    func loadEpisodes(for seasonId: Int, success: @escaping SuccessEpisodes, failure: @escaping Failure)
}

class SeriesDetailService: Service, SeriesDetailServiceProtocol {

    func loadDetails(for seriesId: Int, success: @escaping SuccessDetails, failure: @escaping Failure) {
        makeRequest(request: SeriesDetailMainRequest(seriesId: seriesId), success: success, failure: failure)
    }
    
    func loadEpisodes(for seasonId: Int, success: @escaping SuccessEpisodes, failure: @escaping Failure) {
        makeRequest(request: SeriesDetailEpisodesRequest(seasonId: seasonId), success: success, failure: failure)
    }
}
