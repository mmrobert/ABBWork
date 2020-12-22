//
//  NetworkServiceTests.swift
//  ABBWorkTests
//
//  Created by boqian cheng on 2020-12-21.
//

import XCTest
@testable import ABBWork
import Combine

class NetworkServiceTests: XCTestCase {
    
    var subject: NetworkServiceProvider!
    var disposables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        subject = NetworkService.shared
        disposables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        subject = nil
        disposables = nil
    }

    func testNetworkService() {
        
        let expectation = XCTestExpectation(description: "Fetching podcasts.")
        
        subject.fetchPodcasts(term: "cnn")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in }, receiveValue: { podcasts in
                XCTAssertTrue(!podcasts.list.isEmpty)
                expectation.fulfill()
            })
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
