//
//  SeriesInfoCellViewModel.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 24/05/22.
//

import Foundation

class SeriesInfoCellViewModel {
    
    // MARK: - Properties

    let service = FavoriteService()
    
    // MARK: - Public methods

    func saveFavorite(viewData: SeriesInfoCellViewData) {
        service.saveFavorite(series: FavoritesSeriesModel(title: viewData.title, urlImage: viewData.urlImage, id: viewData.id, isFavorite: true))
    }
    
    func deleteFavorite(viewData: SeriesInfoCellViewData) {
        service.deleteFavorite(series: FavoritesSeriesModel(title: viewData.title, urlImage: viewData.urlImage, id: viewData.id, isFavorite: false))
    }
}
