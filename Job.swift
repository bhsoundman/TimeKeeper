import Foundation

// MARK: - Job
struct Job: Codable, Equatable, Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var client: String
    var startDate: Date
    var days: [JobDay]
    var crew: [CrewEntry]
}

// MARK: - CrewEntry
struct CrewEntry: Codable, Equatable, Hashable, Identifiable {
    var id: UUID = UUID()
    var member: CrewMember
    var position: String
}

// MARK: - JobDay
struct JobDay: Codable, Equatable, Hashable, Identifiable {
    var id: UUID = UUID()
    var date: Date
    var timeStamps: [TimeStamp]
    
    // Optional helper to format date for display
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
