//
//  MainEntryView.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import SwiftUI

struct MainEntryView: View {
    
    @ObservedObject var viewModel = PodcastListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Search view, binding to viewModel for network search 
                SearchBarView(searchText: $viewModel.term)
                // list view
                List(viewModel.list) { podcast in
                    PodcastCellView(podcast: podcast)
                }
                .navigationBarTitle("Podcasts")
                .resignKeyboardOnDragGesture()
            }
        }
    }
}

struct MainEntryView_Previews: PreviewProvider {
    static var previews: some View {
        MainEntryView()
    }
}
