//
//  SeriesServiceTests.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import XCTest
@testable import TVSeriesApp

class SeriesServiceTests: XCTestCase {
    
    func testLoadSeries_returnsFailure() {
        let apiMock = ApiProviderMock()
        
        let service = SeriesService(apiProvider: apiMock)
        service.loadSeries(for: 123, success: {_ in
            XCTFail("Should not be success")

        }, failure: { error in
            XCTAssert(true)

        })
    }
    
    func testLoadSeries_returnsSuccess() {
        guard let response = FileRepresentation.getContent(from: "loadSeriesSuccess", type: [SeriesResponse].self) else {
            XCTFail("Could not load content from file ")
            return
        }

        let apiMock = ApiProviderMock()
        apiMock.response = response
        
        let service = SeriesService(apiProvider: apiMock)
        service.loadSeries(for: 123, success: { response in
            XCTAssertEqual(response.first?.id, 250)
            XCTAssertEqual(response.first?.name, "Kirby Buckets")
        }, failure: { error in
            XCTFail("Should not fail")
        })
    }
    
    func testSearchSerie_returnsFailure() {
        let apiMock = ApiProviderMock()
        
        let service = SeriesService(apiProvider: apiMock)
        service.searchSerie(for: "test", success: { _ in
            XCTFail("Should not be success")

        }, failure: { error in
            XCTAssert(true)

        })
    }
    
    func testSearchSerie_returnsSuccess() {
        guard let response = FileRepresentation.getContent(from: "loadSearchSeriesSuccess", type: [SeriesSearchResponse].self) else {
            XCTFail("Could not load content from file ")
            return
        }

        let apiMock = ApiProviderMock()
        apiMock.response = response
        
        let service = SeriesService(apiProvider: apiMock)
        service.searchSerie(for: "test", success: { response in
            XCTAssertEqual(response.first?.show.id, 12444)
            XCTAssertEqual(response.first?.show.name, "Johnny Test")
        }, failure: { error in
            XCTFail("Should not fail")
        })
    }
}
