import SwiftUI

struct CrewMemberNameView: View {
    @Binding var crewMember: CrewMember

    var body: some View {
        VStack(alignment: .leading) {
            TextField("First Name", text: $crewMember.firstName)
            TextField("Last Name", text: $crewMember.lastName)
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }
}

struct CrewMemberNameView_Previews: PreviewProvider {
    @State static var sampleMember = CrewMember(id: UUID(), firstName: "Bill", lastName: "Hart", email: "bill@example.com", phone: "555-5555", position: "Tech", company: "PSI")

    static var previews: some View {
        CrewMemberNameView(crewMember: $sampleMember)
    }
}
