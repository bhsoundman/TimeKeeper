import SwiftUI

struct GlobalRosterView: View {
    @ObservedObject var dataStore: DataStore
    @State private var editingMember: CrewMember?

    var body: some View {
        NavigationView {
            List {
                ForEach(dataStore.crewMembers.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(dataStore.crewMembers[index].displayName)
                                .font(.headline)
                            Text(dataStore.crewMembers[index].position)
                                .font(.subheadline)
                        }
                        Spacer()
                        Button("Edit") {
                            editingMember = dataStore.crewMembers[index]
                        }
                    }
                }
                .onDelete { indexSet in
                    dataStore.crewMembers.remove(atOffsets: indexSet)
                }
            }
            .sheet(item: $editingMember) { member in
                if let index = dataStore.crewMembers.firstIndex(where: { $0.id == member.id }) {
                    CrewMemberContactView(crewMember: $dataStore.crewMembers[index])
                }
            }
            .navigationTitle("Global Roster")
        }
    }
}
