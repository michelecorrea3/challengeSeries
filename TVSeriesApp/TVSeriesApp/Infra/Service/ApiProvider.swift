//
//  ApiProvider.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Alamofire
import Foundation

protocol ApiProviderProtocol {
    func makeRequest<T: Decodable>(request: RequestProtocol, success: @escaping ((T) -> Void), failure: @escaping ((SeriesError) -> Void))
}

class ApiProvider: ApiProviderProtocol {
    func makeRequest<T: Decodable>(request: RequestProtocol, success: @escaping ((T) -> Void), failure: @escaping ((SeriesError) -> Void)) {
        
        AF.request(request.url,
                   method: getMethod(request.method),
                   parameters: request.query)
            
            .responseDecodable(of: T.self) { response in

                guard let result = response.value, response.error == nil else {
                    failure(SeriesError.generic)
                    return
                }
                
                success(result)
            }
    }
    
    private func getMethod(_ method: HTTPMethod) -> Alamofire.HTTPMethod {
        Alamofire.HTTPMethod(rawValue: method.rawValue)
    }
}
