//
//  EpisodesDetailsViewModelTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 23/05/22.
//

import XCTest
@testable import TVSeriesApp

class SeriesDetailViewModelTests: XCTestCase {
    func testLoadSeriesDetails_returnsSuccess() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))
        
        // When
        viewModel.loadSeriesDetails(with: 122)
        
        // Then
        XCTAssert(serviceSpy.loadDetailsCalled)
        XCTAssert(serviceSpy.loadEpisodesCalled)
        XCTAssertEqual(viewModel.data?.name, "name")
    }
    
    func testLoadSeriesDetails_returnsFailure() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        serviceSpy.returnSuccess = false
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))
        
        // When
        viewModel.loadSeriesDetails(with: 122)

        // Then
        XCTAssert(serviceSpy.loadDetailsCalled)
        assertEquatable(observable: viewModel.state.value, equatable: Observable(SeriesDetailState.error))
    }
    
    func testLoadEpisodeDetails_withoutParams() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))
        
        // When
        viewModel.loadSeriesDetails(with: nil)
        
        // Then
        XCTAssertFalse(serviceSpy.loadDetailsCalled)
        XCTAssertFalse(serviceSpy.loadEpisodesCalled)
    }
    
    func testNumberOfSections_validData() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))
        viewModel.loadSeriesDetails(with: 122)

        // When
        let numberOfSections = viewModel.numberOfSections()
        
        // Then
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfSections_invalidData() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))

        // When
        let numberOfSections = viewModel.numberOfSections()
        
        // Then
        XCTAssertEqual(numberOfSections, 0)
    }
    
    func testNumberOfRowsForSection_validData() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))
        viewModel.loadSeriesDetails(with: 122)

        // When
        let numberOfRowsForSection = viewModel.numberOfRowsForSection(section: 0)
        
        // Then
        XCTAssertEqual(numberOfRowsForSection, 1)
    }
    
    func testNumberOfRowsForSection_sectionDifferentFromZero() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))
        viewModel.loadSeriesDetails(with: 122)

        // When
        let numberOfRowsForSection = viewModel.numberOfRowsForSection(section: 1)
        
        // Then
        XCTAssertEqual(numberOfRowsForSection, 1)
    }
    
    func testNumberOfRowsForSection_sectionDifferentFromZero_invalidData() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))

        // When
        let numberOfRowsForSection = viewModel.numberOfRowsForSection(section: 1)
        
        // Then
        XCTAssertEqual(numberOfRowsForSection, 1)
    }
    
    func testGetParamsDTO_validData() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))
        viewModel.loadSeriesDetails(with: 122)

        // When
        let params = viewModel.getParamsDTO(indexPath: IndexPath(row: 0, section: 1))
        
        // Then
        XCTAssertEqual(params.id, 123)
        XCTAssertEqual(params.season, 2)
        XCTAssertEqual(params.number, 12)
    }
    
    func testGetParamsDTO_invalidData() {
        // Given
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let viewModel = SeriesDetailViewModel(manager: SeriesDetailManager(service: serviceSpy))

        // When
        let params = viewModel.getParamsDTO(indexPath: IndexPath(row: 0, section: 2))
        
        // Then
        XCTAssertEqual(params.id, 0)
        XCTAssertEqual(params.season, 0)
        XCTAssertEqual(params.number, 0)
    }
}


