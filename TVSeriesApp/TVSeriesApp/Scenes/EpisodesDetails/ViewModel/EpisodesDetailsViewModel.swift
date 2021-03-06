//
//  EpisodesDetailsViewModel.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

enum EpisodesDetailsState {
    case initial
    case loading
    case error
    case data
}

protocol EpisodesDetailsViewModelProtocol {
    var state: Observable<EpisodesDetailsState> { get }
    var data: EpisodesDetailsViewData? { get }
    func loadEpisodeDetails()
    func setupParams(with params: EpisodeParamsDTO)
}

class EpisodesDetailsViewModel: EpisodesDetailsViewModelProtocol {
    
    // MARK: - Public properties

    var state: Observable<EpisodesDetailsState> = Observable(.initial)
    var data: EpisodesDetailsViewData?
    
    // MARK: - Private properties

    private var paramsDTO: EpisodeParamsDTO?
    private let service: EpisodesDetailsServiceProtocol

    // MARK: - Initializers

    init(service: EpisodesDetailsServiceProtocol = EpisodesDetailsService()) {
        self.service = service
    }
    
    // MARK: - Public methods
    
    func setupParams(with params: EpisodeParamsDTO) {
        paramsDTO = params
    }
    
    func loadEpisodeDetails() {
        self.state.value = .loading
        
        guard let paramsDTO = paramsDTO else {
            return
        }
        
        service.loadDetails(for: paramsDTO.id, season: paramsDTO.season, number: paramsDTO.number) { (response) in
            self.data = EpisodesDetailsViewData(name: response.name, number: response.number, season: response.season, urlImage: response.image?.medium ?? "", summary: response.summary)
            self.state.value = .data
        } failure: { _ in
            self.state.value = .error
        }
    }
}
