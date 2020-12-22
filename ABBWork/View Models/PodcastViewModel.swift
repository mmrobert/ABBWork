//
//  PodcastViewModel.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import Foundation

struct PodcastViewModel: Identifiable {
    var id = UUID()
    var artistName: String?
    var collectionName: String?
    var artworkUrl100: String?
    
    init(dataModel: PodcastDataModel? = nil) {
        self.artistName = dataModel?.artistName
        self.collectionName = dataModel?.collectionName
        self.artworkUrl100 = dataModel?.artworkUrl100
    }
}
