//
//  MockNetworkServiceTests.swift
//  ABBWorkTests
//
//  Created by boqian cheng on 2020-12-21.
//

import XCTest
@testable import ABBWork
import Combine

class MockNetworkServiceTests: XCTestCase {
    
    var subject: NetworkServiceProvider!
    var disposables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        subject = MockNetworkService.shared
        disposables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        subject = nil
        disposables = nil
    }

    func testMockNetworkService() {
        
        let expectation = XCTestExpectation(description: "Fetching podcasts.")
        let expectedDataModel = [PodcastDataModel(artistName: "cnn", collectionName: "cnn video", artworkUrl100: nil), PodcastDataModel(artistName: "cnn12", collectionName: "cnn12 video", artworkUrl100: "https://cnn12")]
        
        subject.fetchPodcasts(term: "")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in }, receiveValue: { podcasts in
                XCTAssertTrue(!podcasts.list.isEmpty)
                let receivedList = podcasts.list.sorted(by: { $0.artistName ?? "" < $1.artistName ?? "" })
                XCTAssertEqual(receivedList, expectedDataModel)
                expectation.fulfill()
            })
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
