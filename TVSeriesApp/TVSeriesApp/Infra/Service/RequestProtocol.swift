//
//  RequestProtocol.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

protocol RequestProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var query: [String: Any] { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
