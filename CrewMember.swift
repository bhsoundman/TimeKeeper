import Foundation

struct CrewMember: Codable, Equatable, Hashable, Identifiable {
    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var position: String
    var company: String
    
    // Computed property for display in lists
    var displayName: String {
        "\(firstName) \(lastName)"
    }
    
    // Alias for older views that expect .name
    var name: String {
        displayName
    }
}
