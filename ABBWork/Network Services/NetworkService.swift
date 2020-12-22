//
//  NetworkService.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import Foundation
import Combine

protocol NetworkServiceProvider {
    func fetchPodcasts(term: String) -> AnyPublisher<PodcastListDataModel, NetworkRequestError>
}

class NetworkService: NetworkServiceProvider {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchPodcasts(term: String) -> AnyPublisher<PodcastListDataModel, NetworkRequestError> {
        let query = ["media": "podcast", "term": term]
        let podRouter = NetworkAPI.podcasts(queryParas: query, bodyParas: nil)
        do {
            let netRequest = try podRouter.makeURLRequest()
            return podRouter.fetchData(request: netRequest)
        } catch let error {
            if let error = error as? NetworkRequestError {
                return Fail(error: error).eraseToAnyPublisher()
            } else {
                let error = NetworkRequestError.other(description: error.localizedDescription)
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
    }
}

