//
//  PodcastListViewModel.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class PodcastListViewModel: ObservableObject {
    
    @Published var term: String = ""
    @Published var list: [PodcastViewModel] = []
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $term
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: fetchPodcasts(term:))
            .store(in: &disposables)
    }
    
    func fetchPodcasts(term: String) {
        if term.count > 0 {
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
}
