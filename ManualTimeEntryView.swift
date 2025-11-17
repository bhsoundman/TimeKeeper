import SwiftUI

struct ManualTimeEntryView: View {
    @Binding var job: Job
    @Environment(\.dismiss) private var dismiss

    @State private var selectedCrewID: UUID?
    @State private var manualDate = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section("Select Crew Member") {
                    Picker("Crew Member", selection: $selectedCrewID) {
                        ForEach(job.crew.indices, id: \.self) { index in
                            Text(job.crew[index].displayName)
                                .tag(job.crew[index].id as UUID?)
                        }
                    }
                }

                Section("Select Date & Time") {
                    DatePicker("Timestamp", selection: $manualDate, displayedComponents: [.date, .hourAndMinute])
                }

                Section {
                    Button("Add Timestamp") {
                        addTimestamp()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Manual Time Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    // MARK: - Helper
    private func addTimestamp() {
        guard let crewID = selectedCrewID,
              let index = job.crew.firstIndex(where: { $0.id == crewID }) else { return }

        // Append timestamp safely
        job.crew[index].timeStamps.append(manualDate)
        dismiss()
    }
}

// MARK: - Preview
struct ManualTimeEntryView_Previews: PreviewProvider {
    @State static var sampleJob = Job(
        id: UUID(),
        name: "Sample Job",
        client: "Sample Client",
        startDate: Date(),
        days: [],
        crew: [
            CrewEntry(
                id: UUID(),
                firstName: "John",
                lastName: "Doe",
                title: "Electrician",
                company: "ABC",
                email: nil,
                phone: nil,
                timeStamps: [] // always non-optional
            )
        ]
    )

    static var previews: some View {
        ManualTimeEntryView(job: $sampleJob)
    }
}
