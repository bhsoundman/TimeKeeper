import SwiftUI

struct CrewMemberContactView: View {
    @Binding var crewMember: CrewMember

    var body: some View {
        Form {
            Section(header: Text("Contact Info")) {
                TextField("Full Name", text: $crewMember.name)
                TextField("Position", text: $crewMember.position)
                TextField("Company", text: $crewMember.company)
                TextField("Phone", text: $crewMember.phone)
                TextField("Email", text: $crewMember.email)
            }
        }
        .navigationTitle("Edit Crew Member")
    }
}

struct CrewMemberContactView_Previews: PreviewProvider {
    @State static var crew = CrewMember(
        id: UUID(),
        name: "John Doe",
        position: "Technician",
        company: "PSI",
        phone: "555-1234",
        email: "john@example.com"
    )

    static var previews: some View {
        CrewMemberContactView(crewMember: $crew)
    }
}
