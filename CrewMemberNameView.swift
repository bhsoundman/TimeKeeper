import SwiftUI

struct CrewMemberNameView: View {
    @Binding var crewMember: CrewMember

    var body: some View {
        VStack {
            TextField("Full Name", text: $crewMember.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

struct CrewMemberNameView_Previews: PreviewProvider {
    @State static var sample = CrewMember(
        id: UUID(),
        name: "John Doe",
        position: "Technician",
        company: "PSI",
        phone: "555-1234",
        email: "john@example.com"
    )

    static var previews: some View {
        CrewMemberNameView(crewMember: $sample)
    }
}
