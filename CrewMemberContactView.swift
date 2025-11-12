import SwiftUI

struct CrewMemberContactView: View {
    @Binding var member: CrewMember

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("First Name", text: $member.firstName)
                TextField("Last Name", text: $member.lastName)
            }
            
            Section(header: Text("Contact")) {
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

struct CrewMemberContactView_Previews: PreviewProvider {
    @State static var sampleMember = CrewMember(
        id: UUID(),
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        phone: "555-1234",
        position: "Technician",
        company: "PSI"
    )

    static var previews: some View {
        CrewMemberContactView(member: $sampleMember)
    }
}
