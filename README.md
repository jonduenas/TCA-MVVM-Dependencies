This example demonstrates my issue of not being able to pass a dependency from an MVVM feature through to a grandchild TCA feature. 

### Setup
- App entry view uses `withDependencies` to override `MyDependency.value` to `false`.
- Initially setup using MVVM with ContentView and ContentViewModel
- Presents a full screen sheet with a new TCA built root reducer.
- The TCA feature can then push a child feature onto its Nav stack.
- Expectation is that the app entry's override of MyDependency should propogate all the way to the grandchild TCA feature.
- Reality is that the grandchild accesses the default live value of MyDependency

### Steps to reproduce
- Launch app and tap "Dependency" button to observe `false` being printed from the ContentViewModel.
- Tap "Sheet" to launch full screen cover of TCA Root Feature. On appear should print `false`, demonstrating that MyDependency is propogating as desired to the TCA Root feature.
- Tap "Push" to push the Child feature onto the stack.
- Tap "Dependency" button to print the MyDependency value and see that it is `true`.
