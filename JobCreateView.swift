import SwiftUI

struct JobCreateView: View {
    @ObservedObject var dataStore: DataStore
    @State private var jobName = ""
    @State private var clientName = ""
    @State private var startDate = Date()
    @State private var numberOfDays = 1

    var body: some View {
        Form {
            TextField("Job Name", text: $jobName)
            TextField("Client Name", text: $clientName)
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            Stepper("Number of Days: \(numberOfDays)", value: $numberOfDays, in: 1...30)

            Button("Create Job") {
                let jobDaysArray = Job.generateJobDays(startDate: startDate, numberOfDays: numberOfDays)

                let newJob = Job(
                    id: UUID(),
                    name: jobName,
                    client: clientName,
                    startDate: startDate,
                    days: jobDaysArray,
                    crew: []
                )

                dataStore.jobs.append(newJob)
            }
        }
        .navigationTitle("Create Job")
    }
}

// MARK: - Preview
struct JobCreateView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        NavigationStack {
            JobCreateView(dataStore: dataStore)
        }
    }
}

