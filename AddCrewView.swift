import SwiftUI

struct AddCrewView: View {
    @ObservedObject var dataStore: DataStore
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var position = ""

    var body: some View {
        Form {
            Section(header: Text("New Crew Member")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Position", text: $position)
            }
            Button("Add Crew Member") {
                let newCrew = CrewMember(
                    firstName: firstName,
                    lastName: lastName,
                    position: position
                )
                dataStore.crewMembers.append(newCrew)
                firstName = ""
                lastName = ""
                position = ""
            }
            .disabled(firstName.isEmpty || lastName.isEmpty)
        }
        .navigationTitle("Add Crew")
    }
}

// MARK: - Preview
struct AddCrewView_Previews: PreviewProvider {
    @StateObject static var dataStore = DataStore()
    static var previews: some View {
        NavigationStack {
            AddCrewView(dataStore: dataStore)
        }
    }
}
