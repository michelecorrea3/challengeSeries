//
//  EpisodesDetailsViewControllerTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 23/05/22.
//

import XCTest
@testable import TVSeriesApp

class EpisodesDetailsViewControllerTests: XCTestCase {
    
    func testViewDidLoad() {
        // Given
        let viewModelMock = EpisodesDetailsViewModelProtocolMock()
        let viewController = EpisodesDetailsViewController(viewModel: viewModelMock)
        
        // When
        viewController.viewDidLoad()
        
        // Then
        XCTAssert(viewModelMock.loadEpisodeDetailsCalled)
        
    }
    
    func testTryAgain() {
        // Given
        let viewModelMock = EpisodesDetailsViewModelProtocolMock()
        let viewController = EpisodesDetailsViewController(viewModel: viewModelMock)
        
        // When
        viewController.tryAgain()
        
        // Then
        XCTAssert(viewModelMock.loadEpisodeDetailsCalled)
        
    }
}
