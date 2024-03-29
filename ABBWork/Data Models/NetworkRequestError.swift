//
//  NetworkRequestError.swift
//  ABBWork
//
//  Created by boqian cheng on 2020-12-21.
//

import Foundation

enum NetworkRequestError: Error {
    case invalidURL(description: String)
    case netConnection(description: String)
    case bodyToJSON(description: String)
    case parsingResponseData(description: String)
    case other(description: String)
}
