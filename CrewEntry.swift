import Foundation

struct CrewEntry: Identifiable, Codable, Equatable {
    var id: UUID
    var firstName: String
    var lastName: String
    var position: String
    var company: String
    var email: String
    var phone: String
    var timeStamps: [Date] = []

    var displayName: String { "\(firstName) \(lastName)" }
}
