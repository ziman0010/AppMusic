//
//  SearchInteractor.swift
//  AppMusic
//
//  Created by Алексей Черанёв on 07.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var netwokService = NetworkService()
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        
        case .some:
            print(".some")
        case .getTracks(let searchText):
            netwokService.fetchTracks(searchText: searchText) { [weak self] searchResponse in
                self?.presenter?.presentData(response: .presentTracks(searchResponse: searchResponse))
            }
            
        }
    }
    
}
