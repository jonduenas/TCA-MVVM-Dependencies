//
//  ChildFeature.swift
//  TCA-MVVM-Dependencies
//
//  Created by Jon Duenas on 5/6/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ChildFeature {
    struct State: Equatable {}

    enum Action {
        case dependencyButtonTapped
    }

    @Dependency(\.myDependency) private var myDependency

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dependencyButtonTapped:
                print("ChildFeature myDependency.value", myDependency.value)
                return .none
            }
        }
    }
}

struct ChildFeatureView: View {
    let store: StoreOf<ChildFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Button("Dependency") {
                viewStore.send(.dependencyButtonTapped)
            }
        }
    }
}
