import SwiftUI

struct ReportView: View {
    @ObservedObject var dataStore: DataStore
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("Search Jobs", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            List {
                ForEach(dataStore.jobs.filter {
                    searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
                }) { job in
                    VStack(alignment: .leading) {
                        Text(job.name).font(.headline)
                        Text("Start: \(job.startDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("Reports")
    }
}
