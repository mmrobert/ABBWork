//
//  AsyncImageView.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-23.
//

import SwiftUI

struct AsyncImage: View {
    
    @StateObject private var loader: ImageLoader
    private let placeholder: Text

    init(url: URL) {
        self.placeholder = Text("Loading ...")
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        //Group {
        VStack {
            if let img = loader.image {
                Image(uiImage: img)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
