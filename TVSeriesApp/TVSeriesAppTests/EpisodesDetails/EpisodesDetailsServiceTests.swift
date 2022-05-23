//
//  EpisodesDetailsServiceTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

import XCTest
@testable import TVSeriesApp

class EpisodesDetailsServiceTests: XCTestCase {
    
    func testLoadDetails_returnsFailure() {
        let apiMock = ApiProviderMock()
        
        let service = EpisodesDetailsService(apiProvider: apiMock)
        service.loadDetails(for: 123, season: 1, number: 2, success: {_ in
            XCTFail("Should not be success")

        }, failure: { error in
            XCTAssert(true)

        })
    }
    
    func testLoadSeries_returnsSuccess() {
        guard let response = FileRepresentation.getContent(from: "loadEpisodesDetailsSuccess", type: EpisodesResponse.self) else {
            XCTFail("Could not load content from file ")
            return
        }

        let apiMock = ApiProviderMock()
        apiMock.response = response
        
        let service = EpisodesDetailsService(apiProvider: apiMock)
        service.loadDetails(for: 123, season: 1, number: 2, success: { response in
            XCTAssertEqual(response.number, 1)
            XCTAssertEqual(response.season, 1)
            XCTAssertEqual(response.name, "Pilot")
        }, failure: { error in
            XCTFail("Should not fail")
        })
    }
}
