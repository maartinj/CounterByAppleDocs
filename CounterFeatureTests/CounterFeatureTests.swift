//
//  CounterFeatureTests.swift
//  CounterFeatureTests
//
//  Created by Marcin Jędrzejak on 02/06/2025.
//

import ComposableArchitecture
import Testing

@testable import CounterByAppleDocs

@MainActor
struct CounterFeatureTests {
    @Test
    func basics() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }

        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        // ❌ State was not expected to change, but a change occurred: …
        //
        //       CounterFeature.State(
        //     −   count: 0,
        //     +   count: 1,
        //         fact: nil,
        //         isLoading: false,
        //         isTimerRunning: false
        //       )
        //
        // (Expected: −, Actual: +)
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
        // ❌ State was not expected to change, but a change occurred: …
        //
        //       CounterFeature.State(
        //     −   count: 1,
        //     +   count: 0,
        //         fact: nil,
        //         isLoading: false,
        //         isTimerRunning: false
        //       )
        //
        // (Expected: −, Actual: +)
    }
}
