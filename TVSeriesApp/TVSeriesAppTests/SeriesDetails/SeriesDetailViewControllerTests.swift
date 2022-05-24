//
//  SeriesDetailViewControllerTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 23/05/22.
//

import XCTest
@testable import TVSeriesApp

class SeriesDetailViewControllerTests: XCTestCase {
    
    func testViewDidLoad() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
        
        // When
        viewController.viewDidLoad()
        
        // Then
        XCTAssert(viewModelMock.loadSeriesDetailsCalled)
    }
    
    func testTryAgain() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
        
        // When
        viewController.tryAgain()
        
        // Then
        XCTAssert(viewModelMock.loadSeriesDetailsCalled)
    }
    
    func testNumberOfSections() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
        
        // When
        let numberOfSections = viewController.numberOfSections(in: UITableView())
        
        // Then
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInSection() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
        
        // When
        let numberOfRowsInSection = viewController.tableView(UITableView(), numberOfRowsInSection: 2)
        
        // Then
        XCTAssertEqual(numberOfRowsInSection, 2)
    }
    
    func testCellForRowAt_seriesDetailHeaderCell_validCell() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        viewModelMock.data = createViewData()
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
        
        let tableView = UITableView()
        tableView.register(SeriesDetailHeaderCell.self, forCellReuseIdentifier: "SeriesDetailHeaderCell")
        
        // When
        let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssert(cell is SeriesDetailHeaderCell)
    }
    
    func testCellForRowAt_seriesDetailEpisodeCell_validCell() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        viewModelMock.data = createViewData()
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
        
        let tableView = UITableView()
        tableView.register(SeriesDetailEpisodeCell.self, forCellReuseIdentifier: "SeriesDetailEpisodeCell")
        
        // When
        let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        
        // Then
        XCTAssert(cell is SeriesDetailEpisodeCell)
    }
    
    func testCellForRowAt_seriesDetailHeaderCell_invalidCell() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        viewModelMock.data = nil
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
        
        let tableView = UITableView()
        tableView.register(SeriesDetailHeaderCell.self, forCellReuseIdentifier: "SeriesDetailHeaderCell")
        
        // When
        let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertFalse(cell is SeriesDetailHeaderCell)
        XCTAssertFalse(cell is SeriesDetailEpisodeCell)
    }
    
    func testTitleForHeaderInSection() {
        // Given
        let viewModelMock = SeriesDetailViewModelProtocolMock()
        viewModelMock.data = createViewData()
        let viewController = SeriesDetailViewController(viewModel: viewModelMock)
                
        // When
        let titleForHeaderInSection = viewController.tableView(UITableView(), titleForHeaderInSection: 1)
        
        // Then
        XCTAssertEqual(titleForHeaderInSection, "Season 1")
    }
    
    // MARK: - Private methods
    
    private func createViewData() -> SeriesDetailViewData {
        return SeriesDetailViewData(model: SeriesDetailModel(mainInfo: SeriesDetailResponse(id: 123, name: "name", genres: [], premiered: "21/10/2010", ended: nil, schedule: SeriesDetailSchedule(days: ["Monday"], time: "22:00"), summary: "summary", image: nil), episodesBySeason: [(1, [EpisodesBySeasonResponse(id: 1, name: "name", number: 1, season: 1)])]))
    }
}


