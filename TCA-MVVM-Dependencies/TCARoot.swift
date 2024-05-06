//
//  TCARoot.swift
//  TCA-MVVM-Dependencies
//
//  Created by Jon Duenas on 5/6/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TCARoot {
    public struct State: Equatable {
        var path = StackState<Path.State>()
    }

    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case pushButtonTapped
        case onAppear
    }

    @Reducer
    public struct Path {
        public enum State: Equatable {
            case childFeature(ChildFeature.State)
        }

        public enum Action {
            case childFeature(ChildFeature.Action)
        }

        public var body: some ReducerOf<Self> {
            Scope(state: \.childFeature, action: \.childFeature) {
                ChildFeature()
            }
        }
    }

    @Dependency(\.myDependency) private var myDependency

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                print("TCARoot myDependency.value", myDependency.value)
                return .none
            case .pushButtonTapped:
                state.path.append(.childFeature(ChildFeature.State()))
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
}

struct TCARootView: View {
    let store: StoreOf<TCARoot>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStackStore(store.scope(state: \.path, action: \.path)) {
                VStack {
                    Text("Root")
                    Button("Push") { viewStore.send(.pushButtonTapped) }
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            } destination: { state in
                switch state {
                case .childFeature:
                    CaseLet(
                        /TCARoot.Path.State.childFeature,
                         action: TCARoot.Path.Action.childFeature
                    ) { childStore in
                        ChildFeatureView(store: childStore)
                    }
                }
            }
        }
    }
}
