import SwiftUI

struct SplashView: View {
    @ObservedObject var dataStore: DataStore
    @State private var isActive = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to TimeKeeper")
                    .font(.largeTitle)
                    .padding()

                Button("Enter") {
                    isActive = true
                }
            }
            .navigationDestination(isPresented: $isActive) {
                DashboardView(dataStore: dataStore)
            }
        }
    }
}

// MARK: - Preview
struct SplashView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        SplashView(dataStore: dataStore)
    }
}

