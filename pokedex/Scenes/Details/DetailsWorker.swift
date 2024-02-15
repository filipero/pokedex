//
//  DetailsWorker.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 11/02/24.
//

import Foundation
import NetworkManager

protocol DetailsWorkerProtocol: AnyObject {
    func getPokemonDetails(request: DetailsRequest, result: @escaping (Pokemon?, Error?) -> ())
}

class DetailsWorker {
    let networkManager: NetworkManager
    init(networkRouter: NetworkRouter = NetworkRouter()) {
        self.networkManager = NetworkManager(router: networkRouter)
    }
}

//MARK: - HomeWorkerProtocol

extension DetailsWorker: DetailsWorkerProtocol {
    func getPokemonDetails(request: DetailsRequest, result: @escaping (Pokemon?, Error?) -> ()) {
        networkManager.request(with: request) { (response: Result<Pokemon?, Error>) in
            switch response {
            case .success(let response):
                result(response, nil)
            case .failure(let error):
                result(nil, error)
            }
        }
    }
}
