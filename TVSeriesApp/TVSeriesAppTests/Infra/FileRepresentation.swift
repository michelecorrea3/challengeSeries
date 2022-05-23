//
//  FileRepresentation.swift
//  TVSeriesAppTests
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

class FileRepresentation {
    static func getContent<T: Decodable>(from fileName: String, type: T.Type) -> T? {
        let bundle = Bundle(for: FileRepresentation.self)
        guard let url = bundle.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return response
    }
}
