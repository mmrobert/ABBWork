//
//  MockNetworkService.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import Foundation
import Combine

class MockNetworkService: NetworkServiceProvider {
    
    static let shared = MockNetworkService()
    
    private init() {}
    
    func fetchPodcasts(term: String) -> AnyPublisher<PodcastListDataModel, NetworkRequestError> {
        return fetchData()
    }
    
    private func fetchData<T>() -> AnyPublisher<T, NetworkRequestError> where T: Decodable {
        
        let responseMock: [String:Any?] =
            ["resultCount": 2,
             "results": [
                ["kind": "podcast",
                 "artistName": "cnn",
                 "collectionName": "cnn video",
                 "artworkUrl100": nil],
                ["kind": "podcast",
                 "artistName": "cnn12",
                 "collectionName": "cnn12 video",
                 "artworkUrl100": "https://cnn12"]
             ]
            ]
        if let responseDataMock = try? JSONSerialization.data(withJSONObject: responseMock, options: []) {
            return Just(responseDataMock)
                .setFailureType(to: NetworkRequestError.self)
                .flatMap(maxPublishers: .max(1)) { [self] data in
                    decode(data)
                }
                .eraseToAnyPublisher()
        } else {
            let error = NetworkRequestError.other(description: "Wrong response format.")
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    private func decode<T>(_ data: Data) -> AnyPublisher<T, NetworkRequestError> where T: Decodable {
        let decoder = JSONDecoder()
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                NetworkRequestError.parsingResponseData(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
