//
//  SeriesRequest.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

class SeriesRequest: RequestProtocol {
    var url: String = NetworkConstants.showSeries
    var method: HTTPMethod = .get
    var query: [String : Any] 
    
    init(for page: Int) {
        query = [
            "page": page
        ]
    }
}
