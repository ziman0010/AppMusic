//
//  SearchPresenter.swift
//  AppMusic
//
//  Created by Алексей Черанёв on 07.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
  func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
  weak var viewController: SearchDisplayLogic?
  
  func presentData(response: Search.Model.Response.ResponseType) {
    
    switch response {
    case .some:
        print("presenter.some")
    case .presentTracks(let searchResults):
        let cells = searchResults?.results.map({ track in
            cellViewModel(from: track)
        }) ?? []
        let searchViewModel = SearchViewModel(cells: cells)
        
        viewController?.displayData(viewModel: .displayTracks(searchViewModel: searchViewModel))
    }
  
  }
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell(
            iconUrlString: track.artworkUrl100 ?? "",
            trackName: track.trackName ?? "",
            collectionName: track.collectionName ?? "",
            artistName: track.artistName)
    }
  
}
