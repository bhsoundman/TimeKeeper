import SwiftUI

struct JobDayCrewView: View {
    @EnvironmentObject var dataStore: DataStore
    @Binding var job: Job
    var day: JobDay

    @State private var selectedCrew: [CrewEntry] = []
    @State private var showingAddTimestampFor: CrewEntry? = nil
    @State private var newTimestamp: Date = Date()

    var body: some View {
        List {
            // MARK: Crew Selection
            Section("Assigned Crew") {
                ForEach(selectedCrew) { crew in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(crew.displayName)
                            Spacer()
                            Button("Add Timestamp") {
                                showingAddTimestampFor = crew
                                newTimestamp = Date()
                            }
                        }

                        // Show timestamps
                        if let dayIndex = job.days.firstIndex(where: { $0.id == day.id }) {
                            let timestamps = job.days[dayIndex].crewTimestamps[crew.id] ?? []
                            ForEach(timestamps.indices, id: \.self) { index in
                                Text("\(timestamps[index], style: .time)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: removeCrew)
            }

            // Add Crew Button
            Section {
                NavigationLink("Add Crew") {
                    JobCrewSelectionView(selectedCrew: $selectedCrew)
                        .environmentObject(dataStore)
                }
            }
        }
        .navigationTitle(day.date, formatter: dateFormatter)
        .sheet(item: $showingAddTimestampFor) { crew in
            VStack {
                DatePicker("Timestamp", selection: $newTimestamp)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                Button("Add") {
                    addTimestamp(for: crew, timestamp: newTimestamp)
                    showingAddTimestampFor = nil
                }
                .padding()
            }
            .padding()
        }
        .onAppear {
            // Preload existing assigned crew for this day
            if let dayIndex = job.days.firstIndex(where: { $0.id == day.id }) {
                selectedCrew = job.days[dayIndex].crew
            }
        }
        .onChange(of: selectedCrew) { newValue in
            // Update job.days with selected crew
            if let dayIndex = job.days.firstIndex(where: { $0.id == day.id }) {
                job.days[dayIndex].crew = newValue
            }
        }
    }

    // MARK: - Helpers

    private func removeCrew(at offsets: IndexSet) {
        selectedCrew.remove(atOffsets: offsets)
    }

    private func addTimestamp(for crew: CrewEntry, timestamp: Date) {
        if let dayIndex = job.days.firstIndex(where: { $0.id == day.id }) {
            var dict = job.days[dayIndex].crewTimestamps
            var arr = dict[crew.id] ?? []
            arr.append(timestamp)
            dict[crew.id] = arr
            job.days[dayIndex].crewTimestamps = dict
        }
    }

    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }
}

// MARK: - Preview
struct JobDayCrewView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    @State static var job = Job(id: UUID(), name: "Test Job", client: "Client", startDate: Date(), days: [
        JobDay(id: UUID(), date: Date())
    ])

    static var previews: some View {
        NavigationStack {
            JobDayCrewView(job: $job, day: job.days[0])
                .environmentObject(dataStore)
        }
    }
}
