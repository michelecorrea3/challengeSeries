//
//  Service.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

enum SeriesError: Error {
    case generic
}

class Service {
    
    private let apiProvider: ApiProviderProtocol
    
    init(apiProvider: ApiProviderProtocol = ApiProvider()) {
        self.apiProvider = apiProvider
    }
    
    func makeRequest<T: Decodable>(request: RequestProtocol, success: @escaping ((T) -> Void), failure: @escaping ((SeriesError) -> Void)) {
        apiProvider.makeRequest(request: request, success: success, failure: failure)
    }
}
