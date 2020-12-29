//
//  AsyncImageLoader.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-23.
//

import Foundation
import Combine
import UIKit

// 1
class AsyncImageLoader: ObservableObject {
    
    private var subscription: AnyCancellable?
    // 2
    @Published private(set) var image: UIImage?
    // 3
    func load(url: URL) {
        subscription = URLSession.shared
            .dataTaskPublisher(for: url)      // 1
            .map { UIImage(data: $0.data) }   // 2
            .replaceError(with: nil)          // 3
            .receive(on: DispatchQueue.main)  // 4
            .assign(to: \.image, on: self)    // 5

    }
    // 4
    func cancel() {
        subscription?.cancel()
    }
}
