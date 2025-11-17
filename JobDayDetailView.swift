import SwiftUI

struct JobDayDetailView: View {
    @ObservedObject var dataStore: DataStore
    @Binding var day: JobDay
    @Binding var job: Job

    @State private var showingAddCrew = false
    @State private var showingAddTime = false

    var body: some View {
        List {
            Section("Crew") {
                ForEach(day.crew.indices, id: \.self) { index in
                    Text(day.crew[index].displayName)
                }

                Button("Add Crew") {
                    showingAddCrew = true
                }
            }

            Section("Time Entries") {
                ForEach(day.crew.indices, id: \.self) { cIndex in
                    ForEach(day.crew[cIndex].timeStamps.indices, id: \.self) { tIndex in
                        Text("Timestamp: \(day.crew[cIndex].timeStamps[tIndex].formatted(.dateTime))")
                    }
                }

                Button("Add Timestamp") {
                    showingAddTime = true
                }
            }
        }
        .navigationTitle(day.formattedDate)
        .sheet(isPresented: $showingAddCrew) {
            // You need to create AddCrewToJobDayView or adjust
            AddCrewToJobView(dataStore: dataStore, jobDay: $day)
        }
        .sheet(isPresented: $showingAddTime) {
            ManualTimeEntryView(job: $job)
        }
        .onDisappear {
            dataStore.updateJob(job)
        }
    }
}

