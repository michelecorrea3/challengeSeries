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
class SeriesDetailViewModel {
    
    // MARK: - Properties

    var state: Observable<SeriesDetailState> = Observable(.initial)
    var data: SeriesDetailViewData?

    // MARK: - Public methods

    func loadSeriesDetails(with id: Int?) {
        state.value = .loading
        
        guard let id = id else { return }
        SeriesDetailManager().loadAllDetails(id: id) { details in
            self.data = SeriesDetailViewData(model: details)
            self.state.value = .data
        } failure: { _ in
            self.state.value = .error
        }
    }
    
    func numberOfSections() -> Int {
        return (data?.model.episodesBySeason.keys.count ?? 0) + 1
    }
    
    func numberOfRowsForSection(section: Int) -> Int {
        return section == 0 ? 1 : (data?.model.episodesBySeason[section]?.count ?? 0)
    }
    
    func getParamsDTO(indexPath: IndexPath) -> EpisodeParamsDTO {
        let id = data?.model.mainInfo.id ?? 0
        let season = data?.model.episodesBySeason[indexPath.section]?[indexPath.row].season ?? 0
        let number = data?.model.episodesBySeason[indexPath.section]?[indexPath.row].number ?? 0
        return EpisodeParamsDTO(id: id, season: season, number: number)
    }
}
