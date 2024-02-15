//
//  PokemonRequest.swift
//  pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit
import NetworkManager

extension PokemonListRequest: Equatable {}

public struct PokemonListRequest {
    let limit: Int?
    let offset: Int?

    public init(
        limit: Int?,
        offset: Int?
    ) {
        self.limit = limit
        self.offset = offset
    }
}

extension PokemonListRequest: EndpointType {
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
        "pokemon/"
    }
    public var httpMethod: HTTPMethod {
        .get
    }

    public var task: HTTPTask {
        var parameters: [String: Any] = [:]

        if let limit {
            parameters["limit"] = limit
        }

        if let offset {
            parameters["offset"] = offset
        }

        return .requestParameters(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: parameters)
    }

    public var headers: HTTPHeaders? {
        nil
    }
}
