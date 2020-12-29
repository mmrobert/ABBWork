//
//  ImageCache.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-23.
//

import Foundation
import UIKit

protocol ImageCacheable {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct ImageCache: ImageCacheable {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
