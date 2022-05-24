//
//  FavoritesSeriesModel.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 24/05/22.
//

import Foundation

class FavoritesSeriesModel: NSObject, NSCoding {
    // MARK: - Properties
    var title: String
    var urlImage: String
    var id: Int
    var isFavorite: Bool
    
    // MARK: - Initializers

    init(title: String, urlImage: String, id: Int, isFavorite: Bool) {
        self.title = title
        self.urlImage = urlImage
        self.id = id
        self.isFavorite = isFavorite
    }

    // MARK: - Public methods
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(urlImage, forKey: "urlImage")
        coder.encode(isFavorite, forKey: "isFavorite")
    }

    required init?(coder: NSCoder) {
        self.id = coder.decodeInteger(forKey: "id")
        self.title = coder.decodeObject(forKey: "title") as? String ?? ""
        self.urlImage = coder.decodeObject(forKey: "urlImage") as? String ?? ""
        self.isFavorite = coder.decodeBool(forKey: "isFavorite")
    }
}
