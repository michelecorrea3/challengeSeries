//
//  EpisodesDetailsService.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

protocol EpisodesDetailsServiceProtocol {
    typealias Success = ((EpisodesResponse) -> Void)
    typealias Failure = ((SeriesError) -> Void)
    
    func loadDetails(for seriesId: Int, season: Int, number: Int, success: @escaping Success, failure: @escaping Failure)
}

class EpisodesDetailsService: Service, EpisodesDetailsServiceProtocol {
    
    func loadDetails(for seriesId: Int, season: Int, number: Int, success: @escaping Success, failure: @escaping Failure) {
        makeRequest(request: EpisodesDetailsRequest(seriesId: seriesId, season: season, number: number), success: success, failure: failure)
    }
}
