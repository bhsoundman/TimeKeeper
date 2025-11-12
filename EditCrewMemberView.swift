import SwiftUI

struct EditCrewMemberView: View {
    @Binding var crewMember: CrewMember

    var body: some View {
        Form {
            TextField("Full Name", text: $crewMember.name)
            TextField("Position", text: $crewMember.position)
            TextField("Company", text: $crewMember.company)
            TextField("Phone Number", text: $crewMember.phone)
            TextField("Email", text: $crewMember.email)
        }
    }
}


// MARK: - Preview
struct EditCrewMemberView_Previews: PreviewProvider {
    @State static var member = CrewMember(
        id: UUID(),
        name: "Test Name",
        position: "Technician",
        company: "ABC",
        phone: "555-5555",
        email: "test@example.com"
    )
    static var previews: some View {
        EditCrewMemberView(crewMember: $member)
    }
}
