//
//  TCA_MVVM_DependenciesApp.swift
//  TCA-MVVM-Dependencies
//
//  Created by Jon Duenas on 5/6/24.
//

import Dependencies
import SwiftUI

struct MyDependency {
    let value: Bool
}

extension MyDependency: DependencyKey {
    static let liveValue = MyDependency(value: true)
}

extension DependencyValues {
    var myDependency: MyDependency {
        get { self[MyDependency.self] }
        set { self[MyDependency.self] = newValue }
    }
}

@main
struct TCA_MVVM_DependenciesApp: App {
    var body: some Scene {
        WindowGroup {
            withDependencies {
                $0.myDependency = MyDependency(value: false)
            } operation: {
                ContentView(viewModel: ContentViewModel())
            }
        }
    }
}
