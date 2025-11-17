import SwiftUI

struct AddCrewToJobView: View {
    @ObservedObject var dataStore: DataStore
    @Binding var jobDay: JobDay      // <-- MUST be a binding to allow mutation

    var body: some View {
        VStack {
            List {
                ForEach(dataStore.crewMembers) { member in
                    Button(member.name) {

                        // Prevent duplicates
                        guard !jobDay.crew.contains(where: { $0.id == member.id }) else { return }

                        // Convert CrewMember → CrewEntry
                        let entry = CrewEntry(
                            id: member.id,
                            firstName: member.firstName,
                            lastName: member.lastName,
                            title: member.position,
                            company: member.company,
                            email: member.email,
                            phone: member.phone,
                            timeStamps: []
                        )

                        jobDay.crew.append(entry)   // <-- Now allowed AND correct type
                    }
                }
            }
        }
        .navigationTitle("Add Crew to Job Day")
    }
}

