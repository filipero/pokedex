//
//  EvolutionsRequest.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 13/02/24.
//

import Foundation
import NetworkManager

public struct EvolutionsRequest {
    let pokemonName: String
}

extension EvolutionsRequest: EndpointType {
    public var headers: HTTPHeaders? {
        nil
    }

    var environmentBaseURL: String {
        switch environment {
        case .production: return "https://pokeapi.co/api/v2/"
        }
    }

    public var environment: NetworkEnvironment {
        .production
    }

    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }

    public var path: String {
        "evolution-chain/\(pokemonName)"
    }
    public var httpMethod: HTTPMethod {
        .get
    }

    public var task: HTTPTask {
        .request
    }
}

extension EvolutionsRequest: Equatable {}

