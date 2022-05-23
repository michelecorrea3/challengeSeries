//
//  EpisodesDetailsServiceProtocolMock.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation
@testable import TVSeriesApp

class EpisodesDetailsServiceProtocolMock: EpisodesDetailsServiceProtocol {
    
    var loadEpisodeDetailsCalled = false
    var returnsSuccess = true
    
    func loadDetails(for seriesId: Int, season: Int, number: Int, success: @escaping Success, failure: @escaping Failure) {
        loadEpisodeDetailsCalled = true
        
        if returnsSuccess {
            success(EpisodesResponse(name: "name", season: 1, number: 1, image: nil, summary: "summary"))

        } else {
            failure(SeriesError.generic)
        }
    }
}
