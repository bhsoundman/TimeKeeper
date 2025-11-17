import Foundation

enum StampType: String, Codable, CaseIterable {
    case start
    case end
}

struct TimeStamp: Identifiable, Codable, Equatable {
    var id: UUID
    var date: Date
    var time: Date
    var type: StampType
}
