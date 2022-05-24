//
//  SeriesResponse.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

struct SeriesResponse: Codable {
    let id: Int
    let name: String
    let image: SeriesImage?
    
    var isFavorited: Bool?
}

struct SeriesImage: Codable {
    let medium: String
}

struct SeriesSearchResponse: Codable {
    let show: SeriesResponse
}
