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
    var returnSuccess = true
    
    func loadDetails(for seriesId: Int, success: @escaping SuccessDetails, failure: @escaping Failure) {
        loadDetailsCalled = true
        
        if returnSuccess {
            success(SeriesDetailResponse(id: 123, name: "name", genres: [], premiered: "21/10/2010", ended: nil, schedule: SeriesDetailSchedule(days: ["Monday"], time: "22:00"), summary: "summary", image: nil))
        } else {
            failure(SeriesError.generic)
        }
    }
    
    func loadEpisodes(for seasonId: Int, success: @escaping SuccessEpisodes, failure: @escaping Failure) {
        loadEpisodesCalled = true
        
        if returnSuccess {
            success([EpisodesBySeasonResponse(id: 123, name: "name", number: 12, season: 2)])
        } else {
            failure(SeriesError.generic)
        }
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
