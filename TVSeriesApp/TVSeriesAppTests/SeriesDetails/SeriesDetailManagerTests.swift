//
//  SeriesDetailManagerTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import XCTest
@testable import TVSeriesApp

class SeriesDetailServiceProtocolMock: SeriesDetailServiceProtocol {
    
    var loadDetailsCalled = false
    var loadEpisodesCalled = false

    func loadDetails(for seriesId: Int, success: @escaping SuccessDetails, failure: @escaping Failure) {
        loadDetailsCalled = true
    }
    
    func loadEpisodes(for seasonId: Int, success: @escaping SuccessEpisodes, failure: @escaping Failure) {
        loadEpisodesCalled = true
    }
    
    
}

class SeriesDetailManagerTest: XCTestCase {
    
    func testNha() {
        let serviceSpy = SeriesDetailServiceProtocolMock()
        let manager = SeriesDetailManager(service: serviceSpy)
    
        manager.loadAllDetails(id: 1) { (response) in
            XCTAssert(serviceSpy.loadDetailsCalled)
        } failure: { (_) in
            XCTFail()
        }

    }
}
