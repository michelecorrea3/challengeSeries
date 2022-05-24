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
    func testLoadSeries_returnsSuccess() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        let viewModel = SeriesViewModel(service: serviceSpy)
        
        // When
        viewModel.loadSeries()
        
        // Then
        XCTAssert(serviceSpy.loadSeriesCalled)
        XCTAssertEqual(viewModel.getViewData(index: 0).id, 1)
    }
    
    func testLoadSeries_returnsFailure() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        serviceSpy.returnsSuccess = false
        let viewModel = SeriesViewModel(service: serviceSpy)

        // When
        viewModel.loadSeries()

        // Then
        XCTAssert(serviceSpy.loadSeriesCalled)
    }

    func testSearchSeries_returnsSuccess() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        let viewModel = SeriesViewModel(service: serviceSpy)
        
        // When
        viewModel.searchSeries(for: "test")
        
        // Then
        XCTAssert(serviceSpy.searchSerieCalled)
        XCTAssertEqual(viewModel.getViewData(index: 0).id, 1)
    }
    
    func testSearchSeries_returnsFailure() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        serviceSpy.returnsSuccess = false
        let viewModel = SeriesViewModel(service: serviceSpy)

        // When
        viewModel.searchSeries(for: "test")

        // Then
        XCTAssert(serviceSpy.searchSerieCalled)
    }
    
    func testSearchTextDidChange_returnsSuccess() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        let viewModel = SeriesViewModel(service: serviceSpy)
        
        // When
        viewModel.searchTextDidChange("")
        
        // Then
        XCTAssert(serviceSpy.loadSeriesCalled)
    }
    
    func testSearchTextDidChange_isNotSearching() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        let viewModel = SeriesViewModel(service: serviceSpy)
        viewModel.isSearching = false
        viewModel.loadSeries()

        // When
        let numberOfRowsInSection = viewModel.numberOfRowsInSection()
        
        // Then
        XCTAssertEqual(numberOfRowsInSection, 1)
    }
    
    func testSearchTextDidChange_isSearching() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        let viewModel = SeriesViewModel(service: serviceSpy)
        viewModel.isSearching = true

        // When
        let numberOfRowsInSection = viewModel.numberOfRowsInSection()
        
        // Then
        XCTAssertEqual(numberOfRowsInSection, 1)
    }
    
    func testLoadMoreSeries_returnsSuccess() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        let viewModel = SeriesViewModel(service: serviceSpy)
        viewModel.loadSeries()

        // When
        viewModel.loadSeries(resetPageCount: false)
        
        // Then
        XCTAssert(serviceSpy.loadSeriesCalled)
        XCTAssertEqual(viewModel.getViewData(index: 0).id, 1)
    }
    
    func testDisplaySearchError_isSearching() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        serviceSpy.returnsSuccess = false
        let viewModel = SeriesViewModel(service: serviceSpy)
        viewModel.isSearching = true
        
        // When
        let displaySearchError = viewModel.displaySearchError()

        // Then
        XCTAssert(displaySearchError)
    }
    
    func testDisplaySearchError_isNotSearching() {
        // Given
        let serviceSpy = SeriesServiceProtocolMock()
        serviceSpy.returnsSuccess = false
        let viewModel = SeriesViewModel(service: serviceSpy)
        viewModel.isSearching = false
        
        // When
        let displaySearchError = viewModel.displaySearchError()

        // Then
        XCTAssertFalse(displaySearchError)
    }
    
}
