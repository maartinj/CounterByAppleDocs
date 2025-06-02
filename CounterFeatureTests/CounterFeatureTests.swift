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

    @Test
    func timer() async {
        let clock = TestClock()

        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        // ❌ An effect returned for this action is still running.
        //    It must complete before the end of the test. …

//        await store.receive(\.timerTick, timeout: .seconds(2)) {
//            $0.count = 1
//        }
        // ✅ Test Suite 'Selected tests' passed.
        //        Executed 1 test, with 0 failures (0 unexpected) in 1.044 (1.046) seconds
        //    or:
        // ❌ Expected to receive an action, but received none after 0.1 seconds.

        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
}
