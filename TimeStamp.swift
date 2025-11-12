import Foundation

// MARK: - StampType
enum StampType: String, Codable {
    case clockIn
    case clockOut
}

// MARK: - TimeStamp
struct TimeStamp: Identifiable, Codable {
    var id: UUID = UUID()
    var type: StampType
    var date: Date
}
