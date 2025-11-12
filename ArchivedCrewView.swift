import SwiftUI

struct ArchivedCrewView: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        NavigationStack {
            List {
                ForEach(dataStore.archivedCrewMembers) { crew in
                    VStack(alignment: .leading) {
                        Text("\(crew.firstName) \(crew.lastName)")
                            .font(.headline)
                        Text(crew.position)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Archived Crew")
        }
    }
}
