//
//  PodcastListViewModel.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import Foundation
import Combine
import SwiftUI

class PodcastListViewModel: ObservableObject {
    
    // for other cases without as binding "term"
    // @Published var viewLoaded: Bool = false
    
    @Published var term: String = ""
    @Published var list: [PodcastViewModel] = []
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $term
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: fetchPodcasts(term:))
            .store(in: &disposables)
        DataCenter.shared.$list
            .sink(receiveValue: { [weak self] list in
                guard let strongSelf = self else { return }
                strongSelf.list = list
            })
            .store(in: &disposables)
    }
    
    func fetchPodcasts(term: String) {
        if term.count > 0 {
            DataCenter.shared.fetchPodcasts(term: term)
        }
    }
}
