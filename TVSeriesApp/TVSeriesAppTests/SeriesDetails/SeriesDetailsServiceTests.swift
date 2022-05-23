//
//  SeriesDetailsServiceTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import XCTest
@testable import TVSeriesApp

class SeriesDetailsServiceTests: XCTestCase {
    
    func testLoadDetails_returnsFailure() {
        let apiMock = ApiProviderMock()
        
        let service = SeriesDetailService(apiProvider: apiMock)
        service.loadDetails(for: 123, success: {_ in
            XCTFail("Should not be success")

        }, failure: { error in
            XCTAssert(true)

        })
    }
    
    func testLoadSeries_returnsSuccess() {
        guard let response = FileRepresentation.getContent(from: "loadDetailsSuccess", type: SeriesDetailResponse.self) else {
            XCTFail("Could not load content from file ")
            return
        }

        let apiMock = ApiProviderMock()
        apiMock.response = response
        
        let service = SeriesDetailService(apiProvider: apiMock)
        service.loadDetails(for: 123, success: { response in
            XCTAssertEqual(response.id, 1)
            XCTAssertEqual(response.name, "Under the Dome")
        }, failure: { error in
            XCTFail("Should not fail")
        })
    }
    
    func testSearchSerie_returnsFailure() {
        let apiMock = ApiProviderMock()
        
        let service = SeriesDetailService(apiProvider: apiMock)
        service.loadEpisodes(for: 123, success: { _ in
            XCTFail("Should not be success")

        }, failure: { error in
            XCTAssert(true)

        })
    }
    
    func testSearchSerie_returnsSuccess() {
        guard let response = FileRepresentation.getContent(from: "loadEpisodesSuccess", type: [EpisodesBySeasonResponse].self) else {
            XCTFail("Could not load content from file ")
            return
        }

        let apiMock = ApiProviderMock()
        apiMock.response = response
        
        let service = SeriesDetailService(apiProvider: apiMock)
        service.loadEpisodes(for: 123, success: { response in
            XCTAssertEqual(response.first?.season, 1)
            XCTAssertEqual(response.first?.number, 1)
            XCTAssertEqual(response.first?.name, "Pilot")
        }, failure: { error in
            XCTFail("Should not fail")
        })
    }
}
