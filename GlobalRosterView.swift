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
                    CrewMemberContactView(member: $dataStore.crewMembers[index])
                }
            }
            .navigationTitle("Global Roster")
        }
    }
}

// MARK: - Preview
struct GlobalRosterView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        GlobalRosterView(dataStore: dataStore)
    }
}
