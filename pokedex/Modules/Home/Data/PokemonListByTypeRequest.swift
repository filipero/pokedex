//
//  TypeRequest.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 13/02/24.
//

import Foundation
import NetworkManager

public struct PokemonListByTypeRequest {
    let type: Pokemon.Types
}

extension PokemonListByTypeRequest: EndpointType {
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
        "type/\(type.rawValue)"
    }
    public var httpMethod: HTTPMethod {
        .get
    }

    public var task: HTTPTask {
        return .request
    }
}

extension PokemonListByTypeRequest: Equatable {}

