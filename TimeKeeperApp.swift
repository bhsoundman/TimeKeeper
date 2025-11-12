import SwiftUI

@main
struct TimeKeeperApp: App {
    @StateObject private var dataStore = DataStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashView(dataStore: dataStore)
            }
        }
    }
}
