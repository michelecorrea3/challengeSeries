//
//  SeriesViewModel.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import Foundation

enum SeriesState {
    case initial
    case loading
    case loadingMore
    case data
    case error
}

class SeriesViewModel {
    
    // MARK: - Public properties

    var state: Observable<SeriesState> = Observable(.initial)
    var isSearching: Bool = false
    
    // MARK: - Private properties

    private var pageCount = 0
    private var data: [SeriesInfoCellViewData] = []
    private let service: SeriesServiceProtocol
    private let favoriteService = FavoriteService()
    
    // MARK: - Initializers

    init(service: SeriesServiceProtocol = SeriesService()) {
        self.service = service
    }
    
    // MARK: - Public methods

    func loadSeries(resetPageCount: Bool = true) {
        if resetPageCount {
            pageCount = 0
        }
        
        isSearching = false
        setLoadingState()
        
        pageCount += 1
        
        service.loadSeries(for: pageCount, success: { [weak self] result in
            self?.data = result.compactMap { show in
                let isFavorited = self?.favoriteService.loadFavorites().contains(where: { $0.id == show.id})

                return SeriesInfoCellViewData(title: show.name, urlImage: show.image?.medium ?? "", id: show.id, isFavorited: isFavorited)
            }
            self?.state.value = .data
        },
        failure: { _ in
            self.state.value = .error
        })
    }
    
    func searchSeries(for name: String) {
        isSearching = true
        pageCount = 0
        
        self.data = []
        self.state.value = .data

        setLoadingState()
        
        service.searchSerie(for: name, success: { [weak self] result in
            self?.data = result.compactMap { show in
                let isFavorited = self?.favoriteService.loadFavorites().contains(where: { $0.id == show.show.id})
                return SeriesInfoCellViewData(title: show.show.name, urlImage: show.show.image?.medium ?? "", id: show.show.id, isFavorited: isFavorited)
            }
            
            self?.state.value = .data
        },
        failure: { [weak self]_ in
            self?.state.value = .error
        })
    }
    
    func searchTextDidChange(_ text: String) {
        if text.isEmpty {
            loadSeries()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return isSearching ? 1 : data.count
    }
    
    func displaySearchError() -> Bool {
        return isSearching && data.count == 0
    }
    
    func getViewData(index: Int) -> SeriesInfoCellViewData {
        data[index]
    }
    
    // MARK: - Private methods

    private func setLoadingState() {
        if pageCount == 0 {
            state.value = .loading
        } else {
            state.value = .loadingMore
        }
    }
}
