//
//  SeriesViewModelTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

import XCTest
@testable import TVSeriesApp

class SeriesViewModelTests: XCTestCase {
    func testLoadEpisodeDetails_returnsSuccess() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        let viewModel = SeriesViewModel(service: serviceSpy)
        
        // When
        viewModel.loadSeries()
        
        // Then
        XCTAssert(serviceSpy.loadSeriesCalled)
    }
    
    func testLoadEpisodeDetails_returnsFailure() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        serviceSpy.returnsSuccess = false
        let viewModel = SeriesViewModel(service: serviceSpy)

        // When
        viewModel.loadSeries()

        // Then
        XCTAssert(serviceSpy.loadSeriesCalled)
    }
//
//    func testLoadEpisodeDetails_withoutParams() {
//        // Given
//        let serviceSpy = EpisodesDetailsServiceProtocolMock()
//        let viewModel = EpisodesDetailsViewModel(service: serviceSpy)
//
//        // When
//        viewModel.loadEpisodeDetails()
//
//        // Then
//        XCTAssertFalse(serviceSpy.loadEpisodeDetailsCalled)
//    }
}
