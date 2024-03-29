//
//  ImageLoader.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-23.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    private let url: URL
    
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }
    
    func load() {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        cancellable = session.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }

    deinit {
        cancel()
    }
}
