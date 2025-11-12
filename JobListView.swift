import SwiftUI

struct JobListView: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        List {
            ForEach(dataStore.jobs) { job in
                NavigationLink(destination: JobDetailView(dataStore: dataStore, job: job)) {
                    VStack(alignment: .leading) {
                        Text(job.client)
                        Text(job.projectName).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Jobs")
    }
}

// MARK: - Preview
struct JobListView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        NavigationStack {
            JobListView(dataStore: dataStore)
        }
    }
}
