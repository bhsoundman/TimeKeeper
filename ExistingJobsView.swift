import SwiftUI

struct ExistingJobsView: View {
    @ObservedObject var dataStore: DataStore
    @State private var editingJob: Job?

    var body: some View {
        NavigationStack {
            List {
                ForEach(dataStore.jobs) { job in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(job.name)
                            Text(job.client)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button("Edit") {
                            editingJob = job
                        }
                    }
                }
                .onDelete { offsets in
                    dataStore.deleteJob(at: offsets)
                }
            }
            .sheet(item: $editingJob) { job in
                if let index = dataStore.jobs.firstIndex(where: { $0.id == job.id }) {
                    JobDetailView(
                        dataStore: dataStore,
                        job: $dataStore.jobs[index]
                    )
                }
            }
            .navigationTitle("Existing Jobs")
        }
    }
}

struct ExistingJobsView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()

    static var previews: some View {
        ExistingJobsView(dataStore: dataStore)
    }
}
