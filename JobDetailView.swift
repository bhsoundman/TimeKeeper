import SwiftUI

struct JobDetailView: View {
    @ObservedObject var dataStore: DataStore
    var job: Job
    @State private var selectedDayIndex = 0

    var body: some View {
        VStack {
            Picker("Day", selection: $selectedDayIndex) {
                ForEach(0..<job.days.count, id: \.self) { index in
                    Text(job.days[index].dateFormatted).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List {
                ForEach(job.days[selectedDayIndex].crewEntries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.member.displayName)
                        ForEach(entry.timeStamps) { stamp in
                            Text("\(stamp.type.rawValue) at \(stamp.timeFormatted)")
                        }
                    }
                }
            }
        }
        .navigationTitle(job.projectName)
    }
}

// MARK: - Preview
struct JobDetailView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        NavigationStack {
            JobDetailView(dataStore: dataStore, job: dataStore.jobs.first ?? Job.sample)
        }
    }
}
