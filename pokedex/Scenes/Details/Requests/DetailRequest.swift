//
//  DetailRequest.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 09/02/24.
//

import UIKit
import NetworkManager

public struct DetailsRequest {
    let pokemonName: String
}

extension DetailsRequest: EndpointType {
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
        "pokemon/\(pokemonName)"
    }
    public var httpMethod: HTTPMethod {
        .get
    }

    public var task: HTTPTask {
        .request
    }
}

extension DetailsRequest: Equatable {}
