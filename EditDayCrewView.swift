import SwiftUI

struct EditDayCrewView: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var job: Job
    let day: JobDay
    
    @State private var selectedCrew: Set<UUID> = []

    @Environment(\.dismiss) var dismiss

    var body: some View {
        List {
            ForEach(dataStore.crewMembers.sorted(by: { $0.lastName < $1.lastName })) { crew in
                MultipleSelectionRow(
                    title: crew.displayName,
                    status: crewAssignmentStatus(for: crew),
                    isSelected: selectedCrew.contains(crew.id)
                ) {
                    if selectedCrew.contains(crew.id) {
                        selectedCrew.remove(crew.id)
                    } else {
                        selectedCrew.insert(crew.id)
                    }
                }
            }
        }
        .navigationTitle("Edit Crew for Day")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    applySelection()
                    dismiss()
                }
                .disabled(selectedCrew.isEmpty)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
        }
        .onAppear {
            // preselect crew already assigned to this day
            selectedCrew = Set(day.crew.map { $0.id })
        }
    }

    enum AssignmentStatus: String {
        case allDays = "✔"
        case someDays = "—"
        case none = "○"
    }

    private func crewAssignmentStatus(for crew: CrewEntry) -> AssignmentStatus {
        let assignedDays = job.days.filter { $0.crew.contains(where: { $0.id == crew.id }) }.count
        if assignedDays == job.days.count && assignedDays > 0 {
            return .allDays
        } else if assignedDays > 0 {
            return .someDays
        } else {
            return .none
        }
    }

    private func applySelection() {
        for crewID in selectedCrew {
            if let crewEntry = dataStore.crewMembers.first(where: { $0.id == crewID }) {
                job.addCrew(crewEntry, toDayWithID: day.id)
            }
        }

        // Remove crew from this day if deselected
        let deselected = day.crew.filter { !selectedCrew.contains($0.id) }
        for crew in deselected {
            if let dayIndex = job.days.firstIndex(where: { $0.id == day.id }) {
                job.days[dayIndex].crew.removeAll { $0.id == crew.id }
            }
        }
    }
}

// MARK: - Preview
struct EditDayCrewView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    @State static var job = Job.sample

    static var previews: some View {
        NavigationStack {
            EditDayCrewView(job: $job, day: job.days.first!)
                .environmentObject(dataStore)
        }
    }
}
