//
//  DataCenter.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-23.
//

import Foundation
import Combine
import CoreData

class DataCenter {
    
    static let shared = DataCenter()
    
    @Published var list: [PodcastViewModel] = []
    private var disposables = Set<AnyCancellable>()
    
    private init() {}
    
    func fetchPodcasts(term: String) {
        NetworkService.shared.fetchPodcasts(term: term)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let strongSelf = self else { return }
                switch value {
                case .failure:
                    // fetch cached from coredata when no network
                    strongSelf.list = CoreDataCache.shared.fetchCachedPodcasts(term: term)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] podcasts in
                guard let strongSelf = self else { return }
                strongSelf.list = podcasts.list.map { data in
                    let pod = PodcastViewModel(dataModel: data)
                    // cache to coredata (only json data)
                    // thumb imgae cache using third party
                    // framework "SDWebImageSwiftUI" buit-in cache
                    // set up in "AppDelegate.swift" file
                    CoreDataCache.shared.cachePodCast(viewModel: pod)
                    return pod
                }
            })
            .store(in: &disposables)
    }
}
