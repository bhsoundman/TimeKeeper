import SwiftUI

struct CrewEntryView: View {
    var crew: CrewMember

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(crew.name)
                    .font(.headline)
                Text(crew.position)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}

struct CrewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        CrewEntryView(crew: CrewMember(
            id: UUID(),
            name: "Jane Doe",
            position: "Technician",
            company: "ABC Productions",
            phone: "555-5555",
            email: "jane@example.com"
        ))
    }
}
