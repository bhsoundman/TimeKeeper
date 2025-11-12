//
//  ManualTimeEntryView.swift
//  TimeKeeper
//
//  Created by Bill on 11/11/25.
//


import SwiftUI

struct ManualTimeEntryView: View {
    @Binding var job: Job
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCrewID: UUID?
    @State private var manualDate = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select Crew Member") {
                    Picker("Crew Member", selection: $selectedCrewID) {
                        ForEach(job.crew) { crew in
                            Text(crew.displayName).tag(crew.id as UUID?)
                        }
                    }
                }
                
                Section("Select Date & Time") {
                    DatePicker("Timestamp", selection: $manualDate, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section {
                    Button("Add Timestamp") {
                        guard let crewID = selectedCrewID,
                              let index = job.crew.firstIndex(where: { $0.id == crewID }) else { return }
                        job.crew[index].timeStamps.append(manualDate)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Manual Time Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
