import SwiftUI

struct EditCrewMemberView: View {
    @Binding var member: CrewMember

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("First Name", text: $member.firstName)
                TextField("Last Name", text: $member.lastName)
            }
            
            Section(header: Text("Contact Info")) {
                TextField("Email", text: $member.email)
                TextField("Phone", text: $member.phone)
            }
            
            Section(header: Text("Work Info")) {
                TextField("Position", text: $member.position)
                TextField("Company", text: $member.company)
            }
        }
        .navigationTitle(member.displayName)
    }
}

struct EditCrewMemberView_Previews: PreviewProvider {
    @State static var sampleMember = CrewMember(
        id: UUID(),
        firstName: "Jane",
        lastName: "Smith",
        email: "jane.smith@example.com",
        phone: "555-9876",
        position: "Manager",
        company: "PSI"
    )

    static var previews: some View {
        EditCrewMemberView(member: $sampleMember)
    }
}
