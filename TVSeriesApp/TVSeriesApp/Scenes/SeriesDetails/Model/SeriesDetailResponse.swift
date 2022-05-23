//
//  SeriesDetailResponse.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

struct SeriesDetailResponse: Codable {
    let id: Int
    let name: String
    let genres: [String]
    let premiered: String
    let ended: String
    let schedule: SeriesDetailSchedule
    let summary: String
    let image: SeriesImage
}

struct SeriesDetailSchedule: Codable {
    let days: [String]
    let time: String
}
