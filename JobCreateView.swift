import SwiftUI

struct JobCreateView: View {
    @EnvironmentObject var dataStore: DataStore
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
                let newJob = Job(
                    name: jobName,
                    client: clientName,
                    startDate: startDate,
                    days: generateJobDays(startDate: startDate, numberOfDays: numberOfDays)
                )
                dataStore.jobs.append(newJob)
            }
        }
        .navigationTitle("Create Job")
    }

    private func generateJobDays(startDate: Date, numberOfDays: Int) -> [JobDay] {
        var days: [JobDay] = []
        for i in 0..<numberOfDays {
            if let dayDate = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                days.append(JobDay(date: dayDate))
            }
        }
        return days
    }
}
