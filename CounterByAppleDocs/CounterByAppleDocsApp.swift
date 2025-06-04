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
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }

    static let storeTwo = Store(initialState: ContactsFeature.State()) {
        ContactsFeature()
    }

    var body: some Scene {
        WindowGroup {
//            AppView(store: CounterByAppleDocsApp.store)
            ContactsView(store: CounterByAppleDocsApp.storeTwo)
        }
    }
}
