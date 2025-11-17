import SwiftUI

struct JobListView: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        List {
            ForEach(dataStore.jobs.indices, id: \.self) { index in
                NavigationLink(destination: JobDetailView(
                    dataStore: dataStore,
                    job: $dataStore.jobs[index]
                )) {
                    VStack(alignment: .leading) {
                        Text(dataStore.jobs[index].name)
                        Text(dataStore.jobs[index].client)
                            .font(.subheadline)
                    }
                }
            }
            .onDelete { indexSet in
                dataStore.jobs.remove(atOffsets: indexSet)
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

