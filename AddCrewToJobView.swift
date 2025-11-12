import SwiftUI

struct AddCrewToJobView: View {
    @ObservedObject var dataStore: DataStore
    @Binding var job: Job
    var dayIndex: Int

    @State private var selectedCrewIDs: Set<UUID> = []

    var body: some View {
        VStack {
            Text("Add Crew for \(job.days[dayIndex].formattedDate)")
                .font(.headline)

            List(dataStore.crewMembers) { crew in
                HStack {
                    Text(crew.displayName)
                    Spacer()
                    if selectedCrewIDs.contains(crew.id) {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggleSelection(crew)
                }
            }

            Button("Add Selected Crew") {
                addSelectedCrew()
            }
            .padding()
        }
    }

    private func toggleSelection(_ crew: CrewMember) {
        if selectedCrewIDs.contains(crew.id) {
            selectedCrewIDs.remove(crew.id)
        } else {
            selectedCrewIDs.insert(crew.id)
        }
    }

    private func addSelectedCrew() {
        for crewID in selectedCrewIDs {
            if let crew = dataStore.crewMembers.first(where: { $0.id == crewID }) {
                if !job.days[dayIndex].crewEntries.contains(where: { $0.member.id == crewID }) {
                    job.days[dayIndex].crewEntries.append(CrewEntry(member: crew))
                }
            }
        }
        selectedCrewIDs.removeAll()
    }
}
