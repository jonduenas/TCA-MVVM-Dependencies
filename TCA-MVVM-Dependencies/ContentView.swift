//
//  ContentView.swift
//  TCA-MVVM-Dependencies
//
//  Created by Jon Duenas on 5/6/24.
//

import ComposableArchitecture
import SwiftUI

@Observable
class ContentViewModel {
    var tcaRootStore: StoreOf<TCARoot>?

    @ObservationIgnored
    @Dependency(\.myDependency) private var myDependency

    func dependencyButtonTapped() {
        print("ContentViewModel myDependency.value", myDependency.value)
    }

    func sheetButtonTapped() {
        withDependencies(from: self) {
            tcaRootStore = Store(initialState: TCARoot.State(), reducer: TCARoot.init)
        }
    }
}

struct ContentView: View {
    @Bindable var viewModel: ContentViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            Button("Dependency") {
                viewModel.dependencyButtonTapped()
            }

            Button("Sheet") {
                viewModel.sheetButtonTapped()
            }
        }
        .padding()
        .fullScreenCover(item: $viewModel.tcaRootStore) { store in
            TCARootView(store: store)
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
