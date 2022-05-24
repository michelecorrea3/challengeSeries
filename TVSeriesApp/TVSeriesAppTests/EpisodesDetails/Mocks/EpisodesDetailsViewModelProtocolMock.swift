//
//  EpisodesDetailsViewModelProtocolMock.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 23/05/22.
//

import XCTest
@testable import TVSeriesApp

class EpisodesDetailsViewModelProtocolMock: EpisodesDetailsViewModelProtocol {
    var state: Observable<EpisodesDetailsState> = Observable(.initial)
    var data: EpisodesDetailsViewData?
    
    var loadEpisodeDetailsCalled = false
    var setupParamsCalled = false
    
    func loadEpisodeDetails() {
        loadEpisodeDetailsCalled = true
    }
    
    func setupParams(with params: EpisodeParamsDTO) {
        setupParamsCalled = true
    }
}
