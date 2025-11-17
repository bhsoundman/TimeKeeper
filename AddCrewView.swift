import SwiftUI

struct AddCrewView: View {
    @ObservedObject var dataStore: DataStore
    @State private var firstNameField = ""
    @State private var lastNameField = ""
    @State private var positionField = ""
    @State private var companyField = ""
    @State private var emailField = ""
    @State private var phoneField = ""

    var body: some View {
        Form {
            Section(header: Text("Crew Member Info")) {
                TextField("First Name", text: $firstNameField)
                TextField("Last Name", text: $lastNameField)
                TextField("Position", text: $positionField)
                TextField("Company", text: $companyField)
                TextField("Email", text: $emailField)
                TextField("Phone", text: $phoneField)
            }

            Button("Add Crew Member") {
                let newMember = CrewMember(
                    id: UUID(),
                    firstName: firstNameField,
                    lastName: lastNameField,
                    email: emailField,
                    phone: phoneField,
                    position: positionField,
                    company: companyField
                )


                dataStore.crewMembers.append(newMember)

                // Clear fields after adding
                firstNameField = ""
                lastNameField = ""
                positionField = ""
                companyField = ""
                emailField = ""
                phoneField = ""
            }
        }
        .navigationTitle("Add Crew Member")
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
