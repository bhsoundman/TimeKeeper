import Foundation

struct CrewMember: Identifiable, Codable {
    var id: UUID
    var name: String
    var position: String
    var company: String
    var phone: String
    var email: String
}

extension CrewMember {
    var displayName: String { name }
}
