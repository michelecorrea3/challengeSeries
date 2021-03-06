//
//  SeriesDetailViewModel.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

enum SeriesDetailState {
    case initial
    case loading
    case error
    case data
}

protocol SeriesDetailViewModelProtocol {
    var state: Observable<SeriesDetailState> { get }
    var data: SeriesDetailViewData? { get }
    
    func loadSeriesDetails(with id: Int?)
    func getParamsDTO(indexPath: IndexPath) -> EpisodeParamsDTO
    func numberOfSections() -> Int
    func numberOfRowsForSection(section: Int) -> Int
}

class SeriesDetailViewModel: SeriesDetailViewModelProtocol {
    
    // MARK: - Public properties

    var state: Observable<SeriesDetailState> = Observable(.initial)
    var data: SeriesDetailViewData?
    
    // MARK: - Private properties
    
    let manager: SeriesDetailManagerProtocol

    // MARK: - Initializers
    init(manager: SeriesDetailManagerProtocol = SeriesDetailManager()) {
        self.manager = manager
    }
    
    // MARK: - Public methods

    func loadSeriesDetails(with id: Int?) {
        state.value = .loading
        
        guard let id = id else { return }
        manager.loadAllDetails(id: id) { details in
            self.data = SeriesDetailViewData(model: details)
            self.state.value = .data
        } failure: { _ in
            self.state.value = .error
        }
    }
    
    func numberOfSections() -> Int {
        guard let viewData = data else {
            return 0
        }
        return viewData.model.episodesBySeason.count + 1
    }
    
    func numberOfRowsForSection(section: Int) -> Int {
        guard let viewData = data, section != 0 else {
            return 1
        }

        return viewData.model.episodesBySeason[section-1].1.count
    }
    
    func getParamsDTO(indexPath: IndexPath) -> EpisodeParamsDTO {
        let id = data?.model.mainInfo.id ?? 0
        let season = data?.model.episodesBySeason[indexPath.section-1].1[indexPath.row].season ?? 0
        let number = data?.model.episodesBySeason[indexPath.section-1].1[indexPath.row].number ?? 0
        return EpisodeParamsDTO(id: id, season: season, number: number)
    }
}
