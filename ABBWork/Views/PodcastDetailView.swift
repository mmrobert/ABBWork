//
//  PodcastDetailView.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-23.
//

import SwiftUI

struct PodcastDetailView: View {
    
    var podcast: PodcastViewModel
    // @State private var zoomed: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(podcast.artistName ?? "")
        }
    }
}

struct PodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("ch")
    }
}
