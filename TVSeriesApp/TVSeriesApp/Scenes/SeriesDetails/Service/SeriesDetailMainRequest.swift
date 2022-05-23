//
//  SeriesDetailMainRequest.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

class SeriesDetailMainRequest: RequestProtocol {
    var url: String = NetworkConstants.seriesDetails
    var method: HTTPMethod = .get
    var query: [String : Any] = [:]
    
    init(seriesId: Int) {
        url = String(format: url, seriesId)
    }
}
