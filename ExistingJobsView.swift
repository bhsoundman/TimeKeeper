import SwiftUI

struct ExistingJobsView: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        List {
            ForEach($dataStore.jobs) { $job in
                NavigationLink(value: job) {
                    VStack(alignment: .leading) {
                        Text(job.name)
                            .font(.headline)
                        Text("Job #: \(job.number)")
                            .font(.subheadline)
                    }
                }
            }
            .onDelete { indexSet in
                dataStore.jobs.remove(atOffsets: indexSet)
            }
        }
        .navigationTitle("Existing Jobs")
    }
}
