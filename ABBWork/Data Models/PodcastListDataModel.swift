//
//  PodcastListDataModel.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import Foundation

struct PodcastListDataModel: Decodable {
    
    let list: [PodcastDataModel]
    
    enum CodingKeys: String, CodingKey {
        case list = "results"
    }
}

