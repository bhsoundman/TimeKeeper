import SwiftUI

struct CreateJobView: View {
    @ObservedObject var dataStore: DataStore
    @State private var client = ""
    @State private var projectName = ""
    @State private var numberOfDays = 1
    @State private var startDate = Date()

    var body: some View {
        Form {
            Section("Job Info") {
                TextField("Client", text: $client)
                TextField("Project Name", text: $projectName)
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                Stepper("Days: \(numberOfDays)", value: $numberOfDays, in: 1...30)
            }

            Button("Create Job") {
                let newJob = Job(
                    client: client,
                    projectName: projectName,
                    days: generateJobDays(startDate: startDate, numberOfDays: numberOfDays)
                )
                dataStore.jobs.append(newJob)
            }
        }
        .navigationTitle("New Job")
    }

    private func generateJobDays(startDate: Date, numberOfDays: Int) -> [JobDay] {
        (0..<numberOfDays).map { offset in
            JobDay(date: Calendar.current.date(byAdding: .day, value: offset, to: startDate) ?? startDate)
        }
    }
}

// MARK: - Preview
struct CreateJobView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        NavigationStack {
            CreateJobView(dataStore: dataStore)
        }
    }
}
