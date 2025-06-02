//
//  AppFeatureTests.swift
//  CounterFeatureTests
//
//  Created by Marcin Jędrzejak on 02/06/2025.
//

import ComposableArchitecture
import Testing

@testable import CounterByAppleDocs

@MainActor
struct AppFeatureTests {
    @Test
    func incrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
}
