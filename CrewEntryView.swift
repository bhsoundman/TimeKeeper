import SwiftUI

struct CrewEntryView: View {
    @Binding var member: CrewMember
    var body: some View {
        HStack {
            Text(member.displayName)
                .font(.headline)
            Spacer()
            Text(member.position)
                .font(.subheadline)
            Text(member.company)
                .font(.subheadline)
        }
        .padding()
    }
}

struct CrewEntryView_Previews: PreviewProvider {
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
        CrewEntryView(member: $sampleMember)
    }
}
