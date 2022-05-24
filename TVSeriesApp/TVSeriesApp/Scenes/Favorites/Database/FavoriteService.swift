//
//  Favorite.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 24/05/22.
//

import Foundation

class FavoriteService {
    
    // MARK: - Public methods
    
    func saveFavorite(series: FavoritesSeriesModel) {
        var favorites = loadFavorites()
        favorites.append(series)
        
        UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: favorites, requiringSecureCoding: false), forKey: DatabaseConstants.loadFavorites)
    }
    
    func deleteFavorite(series: FavoritesSeriesModel) {
        var favorites = loadFavorites()
        favorites.removeAll(where: { $0.id == series.id })
        
        UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: favorites, requiringSecureCoding: false), forKey: DatabaseConstants.loadFavorites)
    }
    
    func loadFavorites() -> [FavoritesSeriesModel] {
        let data = UserDefaults.standard.data(forKey: DatabaseConstants.loadFavorites) ?? Data()
        var favorites: [FavoritesSeriesModel] = []
        favorites = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? [FavoritesSeriesModel] ?? []
        return favorites.sorted { $0.title < $1.title }
    }
    
}

