//
//  AsyncWebImageView.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-23.
//

import Foundation
import SwiftUI

struct AsyncWebImageView: View {
    
    private var url: URL
    private var placeHolder: Image
    
    @ObservedObject var loader = AsyncImageLoader()
    
    init(url: URL, placeHolder: Image) {
        self.url = url
        self.placeHolder = placeHolder
        self.loader.load(url: self.url)
    }
    var body: some View {
        VStack {
            // 3
            if let img = loader.image {
                Image(uiImage: img)
                    .renderingMode(.original)
                    .resizable()
            }
        }
        .onDisappear { self.loader.cancel() }
    }
}
