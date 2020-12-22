//
//  PodcastCellView.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PodcastCellView: View {
    
    var podcast: PodcastViewModel
    
    init(podcast: PodcastViewModel) {
        self.podcast = podcast
    }
    
    var body: some View {
        HStack {
            // using third party framework "SDWebImageSwiftUI"
            // for image loading with buit-in cache
            WebImage(url: URL(string: podcast.artworkUrl100 ?? ""))
                .resizable()
                .placeholder(Image("Appleicon"))
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                // original thumb size should be 100*100
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(podcast.artistName ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text(podcast.collectionName ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        let podData = PodcastDataModel(artistName: "cnn", collectionName: "cnn video", artworkUrl100: nil)
        let pod = PodcastViewModel(dataModel: podData)
        PodcastCellView(podcast: pod)
    }
}

