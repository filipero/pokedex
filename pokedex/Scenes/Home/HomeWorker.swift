//
//  HomeWorker.swift
//  pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import Foundation
import NetworkManager

protocol HomeWorkerProtocol: AnyObject {
    func getPokemonList(request: PokemonListRequest, result: @escaping ([PokemonListItem]?, Error?) -> ())
}

class HomeWorker {
    let networkManager: NetworkManager
    init(networkRouter: NetworkRouter = NetworkRouter()) {
        self.networkManager = NetworkManager(router: networkRouter)
    }
}

//MARK: - HomeWorkerProtocol

extension HomeWorker: HomeWorkerProtocol {
    func getPokemonList(request: PokemonListRequest, result: @escaping ([PokemonListItem]?, Error?) -> ()) {
        networkManager.request(with: request) { (response: Result<PokemonListResponse?, Error>) in
            switch response {
            case .success(let response):
                result(response?.results, nil)
            case .failure(let error):
                result(nil, error)
            }
        }
    }
}
