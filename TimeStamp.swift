import Foundation

struct TimeStamp: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date
    var time: String
}
