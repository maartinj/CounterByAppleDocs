//
//  CounterByAppleDocsApp.swift
//  CounterByAppleDocs
//
//  Created by Marcin Jędrzejak on 02/06/2025.
//

import ComposableArchitecture
import SwiftUI

@main
struct CounterByAppleDocsApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            CounterView(store: CounterByAppleDocsApp.store)
        }
    }
}
