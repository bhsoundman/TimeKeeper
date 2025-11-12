import SwiftUI

struct JobCrewSelectionView: View {
    @ObservedObject var dataStore: DataStore
    @Binding var selectedCrew: [CrewMember]

    var body: some View {
        List {
            ForEach(dataStore.crewMembers) { crew in
                HStack {
                    Text(crew.displayName)
                    Spacer()
                    if selectedCrew.contains(where: { $0.id == crew.id }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggleCrewSelection(crew)
                }
            }
        }
        .navigationTitle("Select Crew")
    }

    private func toggleCrewSelection(_ crew: CrewMember) {
        if let index = selectedCrew.firstIndex(where: { $0.id == crew.id }) {
            selectedCrew.remove(at: index)
        } else {
            selectedCrew.append(crew)
        }
    }
}

// MARK: - Preview
struct JobCrewSelectionView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    @State static var selectedCrew: [CrewMember] = []
    static var previews: some View {
        NavigationStack {
            JobCrewSelectionView(dataStore: dataStore, selectedCrew: $selectedCrew)
        }
    }
}
