//
//  EpisodesDetailsViewModelTests.swift.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import XCTest
@testable import TVSeriesApp

class EpisodesDetailsViewModelTests: XCTestCase {
    func testLoadEpisodeDetails_returnsSuccess() {
        // Given
        let serviceSpy = EpisodesDetailsServiceProtocolMock()
        let viewModel = EpisodesDetailsViewModel(service: serviceSpy)
        viewModel.setupParams(with: EpisodeParamsDTO(id: 1, season: 1, number: 1))
        
        // When
        viewModel.loadEpisodeDetails()
        
        // Then
        XCTAssert(serviceSpy.loadEpisodeDetailsCalled)
        XCTAssertEqual(viewModel.data?.name, "name")
    }
    
    func testLoadEpisodeDetails_returnsFailure() {
        // Given
        let serviceSpy = EpisodesDetailsServiceProtocolMock()
        serviceSpy.returnsSuccess = false
        let viewModel = EpisodesDetailsViewModel(service: serviceSpy)
        viewModel.setupParams(with: EpisodeParamsDTO(id: 1, season: 1, number: 1))
        
        // When
        viewModel.loadEpisodeDetails()
        
        // Then
        XCTAssert(serviceSpy.loadEpisodeDetailsCalled)
        assertEquatable(observable: viewModel.state.value, equatable: Observable(EpisodesDetailsState.error))
    }
    
    func testLoadEpisodeDetails_withoutParams() {
        // Given
        let serviceSpy = EpisodesDetailsServiceProtocolMock()
        let viewModel = EpisodesDetailsViewModel(service: serviceSpy)
        
        // When
        viewModel.loadEpisodeDetails()
        
        // Then
        XCTAssertFalse(serviceSpy.loadEpisodeDetailsCalled)
    }
}


