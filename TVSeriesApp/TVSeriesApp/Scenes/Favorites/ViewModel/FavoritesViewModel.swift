//
//  FavoritesViewModel.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 24/05/22.
//

import Foundation

enum FavoritesState {
    case initial
    case loading
    case empty
    case data
}

class FavoritesViewModel {
    
    // MARK: - Public properties

    var state: Observable<FavoritesState> = Observable(.initial)
    
    // MARK: - Private properties

    private var data: [FavoritesSeriesModel] = []
    private let service = FavoriteService()
    
    // MARK: - Public methods
    
    func loadFavorites() {
        state.value = .loading
        
        self.data = service.loadFavorites()
        if data.isEmpty {
            self.state.value = .empty
        } else {
            self.state.value = .data
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return data.count
    }
    
    func getViewData(index: Int) -> FavoritesSeriesModel {
        return data[index]
    }
}
