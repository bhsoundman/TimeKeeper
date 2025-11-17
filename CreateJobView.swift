import SwiftUI

struct CreateJobView: View {
    @ObservedObject var dataStore: DataStore

    @State private var jobName = ""
    @State private var clientName = ""
    @State private var startDate = Date()
    @State private var numberOfDays = 1

    @State private var showCreatedAlert = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section("Job Info") {
                TextField("Job Name", text: $jobName)
                TextField("Client Name", text: $clientName)
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            }

            Section("Schedule") {
                Stepper("Number of Days: \(numberOfDays)", value: $numberOfDays, in: 1...30)
            }

            Section {
                Button("Create Job") {
                    createJob()
                }
                .disabled(jobName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .navigationTitle("Create Job")
        .alert("Job Created", isPresented: $showCreatedAlert) {
            Button("OK") {
                // close this view and return to previous screen
                dismiss()
            }
        } message: {
            Text("Your new job has been successfully created.")
        }
    }

    // MARK: - Actions
    private func createJob() {
        // build the days array using the helper
        let jobDaysArray = Job.generateJobDays(startDate: startDate, numberOfDays: numberOfDays)

        // create the job (match your Job initializer)
        let newJob = Job(
            id: UUID(),
            name: jobName.trimmingCharacters(in: .whitespacesAndNewlines),
            client: clientName.trimmingCharacters(in: .whitespacesAndNewlines),
            startDate: startDate,
            endDate: nil,
            days: jobDaysArray,
            crew: []
        )

        // save to datastore (this also calls saveJobs() per your DataStore)
        dataStore.addJob(newJob)

        // show confirmation UI
        showCreatedAlert = true
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

