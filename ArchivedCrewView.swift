import SwiftUI

struct ArchivedCrewView: View {
    @ObservedObject var dataStore: DataStore
    @State private var searchText = ""

    // Access the array directly, no $ or dynamicMember
    var filteredCrew: [CrewMember] {
        dataStore.archivedCrewMembers.filter { member in
            searchText.isEmpty || member.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack {
            TextField("Search archived crew", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            List(filteredCrew) { member in
                Text(member.name)
            }
        }
        .navigationTitle("Archived Crew")
    }
}
