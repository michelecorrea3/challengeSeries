//
//  SeriesDetailViewModelProtocolMock.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 23/05/22.
//

import XCTest
@testable import TVSeriesApp

class SeriesDetailViewModelProtocolMock: SeriesDetailViewModelProtocol {
    var state: Observable<SeriesDetailState> = Observable(.initial)
    
    var data: SeriesDetailViewData?
    
    var loadSeriesDetailsCalled = false
    
    func loadSeriesDetails(with id: Int?) {
        loadSeriesDetailsCalled = true
    }
    
    func getParamsDTO(indexPath: IndexPath) -> EpisodeParamsDTO {
        return EpisodeParamsDTO(id: 1, season: 2, number: 3)
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRowsForSection(section: Int) -> Int {
        return 2
    }
}
