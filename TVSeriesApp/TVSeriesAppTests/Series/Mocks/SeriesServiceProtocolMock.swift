//
//  SeriesServiceProtocolMock.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation
@testable import TVSeriesApp

class SeriesServiceProtocolMock: SeriesServiceProtocol {
    var loadSeriesCalled: Bool = false
    var searchSerieCalled: Bool = false
    var returnsSuccess = true
    
    func loadSeries(for page: Int, success: @escaping Success, failure: @escaping Failure) {
        loadSeriesCalled = true
        
        if returnsSuccess {
            success([SeriesResponse(id: 1, name: "name", image: nil)])
        } else {
            failure(SeriesError.generic)
        }
    }
    
    func searchSerie(for name: String, success: @escaping SearchSuccess, failure: @escaping Failure) {
        searchSerieCalled = true
        
        if returnsSuccess {
            success([SeriesSearchResponse(show: SeriesResponse(id: 1, name: "name", image: nil))])
        } else {
            failure(SeriesError.generic)
        }
    }
}
