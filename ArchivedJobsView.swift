import SwiftUI

struct ArchivedJobsView: View {
    @ObservedObject var dataStore: DataStore

    // Step 4: Filter only archived jobs
    var archivedJobs: [Job] {
        dataStore.jobs.filter { $0.archived }
    }

    var body: some View {
        List {
            ForEach(archivedJobs.indices, id: \.self) { index in
                let job = archivedJobs[index]
                VStack(alignment: .leading) {
                    Text(job.name)
                        .font(.headline)
                    Text(job.client)
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle("Archived Jobs")
    }
}
