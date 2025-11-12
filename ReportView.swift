import SwiftUI

struct ReportView: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        List {
            ForEach(dataStore.jobs) { job in
                VStack(alignment: .leading) {
                    Text(job.projectName)
                        .font(.headline)
                    Text(job.client)
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle("Reports")
    }
}

// MARK: - Preview
struct ReportView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        NavigationStack {
            ReportView(dataStore: dataStore)
        }
    }
}
