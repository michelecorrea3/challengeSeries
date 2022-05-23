//
//  SeriesService.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

protocol SeriesServiceProtocol {
    typealias SearchSuccess = (([SeriesSearchResponse]) -> Void)
    typealias Success = (([SeriesResponse]) -> Void)
    typealias Failure = ((SeriesError) -> Void)
    
    func loadSeries(for page: Int, success: @escaping Success, failure: @escaping Failure)
    func searchSerie(for name: String, success: @escaping SearchSuccess, failure: @escaping Failure)
}

class SeriesService: Service, SeriesServiceProtocol {
    
    func loadSeries(for page: Int, success: @escaping Success, failure: @escaping Failure) {
        makeRequest(request: SeriesRequest(for: page), success: success, failure: failure)
    }
    
    func searchSerie(for name: String, success: @escaping SearchSuccess, failure: @escaping Failure) {
        makeRequest(request: SeriesSearchRequest(for: name), success: success, failure: failure)
    }
}

