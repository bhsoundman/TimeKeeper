import Foundation

struct Job: Identifiable, Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var name: String
    var client: String
    var startDate: Date
    var days: [JobDay]
    
    // Optional helper for hash/equality (if needed)
    static func == (lhs: Job, rhs: Job) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct JobDay: Identifiable, Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var date: Date
    var crewEntries: [CrewEntry] = []
    
    static func == (lhs: JobDay, rhs: JobDay) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct CrewEntry: Identifiable, Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var member: CrewMember
    var timeStamps: [TimeStamp] = []
    
    static func == (lhs: CrewEntry, rhs: CrewEntry) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TimeStamp: Identifiable, Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var type: StampType
    var date: Date
    
    static func == (lhs: TimeStamp, rhs: TimeStamp) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum StampType: String, Codable {
    case clockIn
    case clockOut
}
