import SwiftUI

struct DashboardView: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Create New Job") {
                    CreateJobView(dataStore: dataStore)
                }
                NavigationLink("Existing Jobs") {
                    ExistingJobsView(dataStore: dataStore)
                }
                NavigationLink("Global Crew Roster") {
                    GlobalRosterView(dataStore: dataStore)
                }
                NavigationLink("Archived Crew") {
                    ArchivedCrewView(dataStore: dataStore)
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}
