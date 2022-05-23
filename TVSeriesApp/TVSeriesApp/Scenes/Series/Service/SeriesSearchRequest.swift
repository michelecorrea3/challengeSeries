//
//  SeriesSearchRequest.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

class SeriesSearchRequest: RequestProtocol {
    var url: String = NetworkConstants.searchSeries
    var method: HTTPMethod = .get
    var query: [String : Any]
    
    init(for name: String) {
        query = [
            "q": name
        ]
    }
}
