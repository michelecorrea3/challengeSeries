//
//  ApiProviderMock.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation
@testable import TVSeriesApp

class ApiProviderMock: ApiProviderProtocol {
    var response: Decodable?
    
    func makeRequest<T>(request: RequestProtocol, success: @escaping ((T) -> Void), failure: @escaping ((SeriesError) -> Void)) where T : Decodable {

        if let response = response as? T {
            success(response)
        } else {
            failure(SeriesError.generic)
        }
    }
}
