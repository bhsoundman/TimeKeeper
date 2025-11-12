import SwiftUI

struct CrewListView: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        List {
            ForEach(dataStore.crewMembers) { crew in
                NavigationLink(destination: CrewEntryView(crew: crew)) {
                    Text(crew.name)
                        .font(.body)
                }
            }
            .onDelete { indexSet in
                dataStore.crewMembers.remove(atOffsets: indexSet)
            }
        }
        .navigationTitle("Crew Members")
    }
}

struct CrewListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CrewListView(dataStore: DataStore())
        }
    }
}
