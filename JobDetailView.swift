
import SwiftUI

struct JobDetailView: View {
    @ObservedObject var dataStore: DataStore
    @Binding var job: Job
    @State private var selectedDay: JobDay?

    var body: some View {
        List {
            Section("Job Info") {
                TextField("Job Name", text: $job.name)
                TextField("Client Name", text: $job.client)
                DatePicker("Start Date", selection: $job.startDate, displayedComponents: .date)
            }

            Section("Days") {
                ForEach(job.days) { day in
                    Button {
                        selectedDay = day
                    } label: {
                        Text(day.formattedDate)
                    }
                }
            }
        }
        .sheet(item: $selectedDay) { day in
            if let index = job.days.firstIndex(where: { $0.id == day.id }) {
                JobDayDetailView(
                    dataStore: dataStore,
                    day: $job.days[index],
                    job: $job
                )
            }
        }
        .navigationTitle("Job Details")
        .onDisappear {
            dataStore.updateJob(job)
        }
    }
}


// MARK: - Preview
struct JobDetailView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    @State static var sampleJob = Job.sample

    static var previews: some View {
        NavigationStack {
            JobDetailView(
                dataStore: dataStore,
                job: $sampleJob
            )
        }
    }
}
