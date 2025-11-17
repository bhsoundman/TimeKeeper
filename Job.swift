import Foundation

// MARK: - CrewEntry
/// Represents a single person on the roster. This is used both as the global crew entry shape
/// and as the job-level crew item. Keep `id` stable — we use it as the identity key everywhere.
struct CrewEntry: Codable, Identifiable, Hashable {
    let id: UUID
    var firstName: String
    var lastName: String
    var title: String?
    var company: String?
    var email: String?
    var phone: String?
    /// Simple list of timestamps for this crew member for whichever context this entry is used.
    /// We store plain `Date` values (in/out entries appended in order). You can extend later to
    /// use a richer TimeStamp struct if you prefer in/out pairs.
    var timeStamps: [Date] = []

    // display helper used by many views
    var displayName: String {
        "\(firstName) \(lastName)"
    }

    // Hashable/Equatable by id only (stable identity)
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CrewEntry, rhs: CrewEntry) -> Bool {
        lhs.id == rhs.id
    }
}


// MARK: - JobDay
struct JobDay: Codable, Identifiable, Hashable {
    let id: UUID
    var date: Date
    /// Crew entries that are present for *this day*. For your app rules we will keep this
    /// synchronized with Job.crew when you add crew to a job (see helpers below).
    var crew: [CrewEntry]

    init(id: UUID = UUID(), date: Date, crew: [CrewEntry] = []) {
        self.id = id
        self.date = date
        self.crew = crew
    }

    // Computed property for display
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    // helper to find a crew entry by id
    func crewIndex(for crewID: UUID) -> Int? {
        crew.firstIndex(where: { $0.id == crewID })
    }

    // Hashable/Equatable based on id
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


// MARK: - Job
struct Job: Identifiable, Codable, Hashable {
    var id: UUID
    var name: String
    var client: String
    var startDate: Date
    var endDate: Date?
    var days: [JobDay]
    /// Job-wide crew roster. Per your requirement, each job's days should share the same crew list.
    /// We'll keep this as the source-of-truth for the roster; helper methods below will push
    /// new crew members into each JobDay so each day shows the same roster.
    var crew: [CrewEntry] = []

    // MARK: - Convenience / helper methods

    /// Adds a CrewEntry to the job roster (if not already present) and to every JobDay.
    /// Returns true if added, false if it was already present.
    mutating func addCrew(_ entry: CrewEntry) -> Bool {
        if crew.contains(where: { $0.id == entry.id }) { return false }
        crew.append(entry)

        // Ensure every day has the crew member as well
        for i in days.indices {
            if !days[i].crew.contains(where: { $0.id == entry.id }) {
                days[i].crew.append(entry)
            }
        }
        return true
    }

    /// Removes a crew member from the job roster and from all days.
    mutating func removeCrew(withID id: UUID) {
        crew.removeAll(where: { $0.id == id })
        for i in days.indices {
            days[i].crew.removeAll(where: { $0.id == id })
        }
    }

    /// Add a crew member to a single day (useful if you want day-specific additions).
    /// This will also add to the job roster if not present (so job-level and day-level stay in sync).
    mutating func addCrew(_ entry: CrewEntry, toDayWithID dayID: UUID) {
        // add to job roster if missing
        if !crew.contains(where: { $0.id == entry.id }) {
            crew.append(entry)
        }
        // find day and add
        if let idx = days.firstIndex(where: { $0.id == dayID }) {
            if !days[idx].crew.contains(where: { $0.id == entry.id }) {
                days[idx].crew.append(entry)
            }
        }
    }

    /// Append a timestamp for a crew member on a specific day
    /// (timestamp is a Date; you can store in/out pairs by alternating push order)
    mutating func appendTimestamp(_ timestamp: Date, forCrewID crewID: UUID, onDayWithID dayID: UUID) {
        guard let dayIndex = days.firstIndex(where: { $0.id == dayID }) else { return }

        // prefer the day-specific crew entry (if exists), otherwise try to add from job roster
        if let crewIndex = days[dayIndex].crew.firstIndex(where: { $0.id == crewID }) {
            days[dayIndex].crew[crewIndex].timeStamps.append(timestamp)
            // keep job.crew in sync as well (append to job-wide entry)
            if let jobCrewIndex = crew.firstIndex(where: { $0.id == crewID }) {
                crew[jobCrewIndex].timeStamps.append(timestamp)
            }
        } else if let jobCrewIndex = crew.firstIndex(where: { $0.id == crewID }) {
            // day didn't have crew entry yet — add it (copy from job roster) and append timestamp
            var newEntry = crew[jobCrewIndex]
            newEntry.timeStamps = [timestamp]
            days[dayIndex].crew.append(newEntry)
            // and append to job roster's timestamps as well
            crew[jobCrewIndex].timeStamps.append(timestamp)
        }
    }

    /// Helper: does this job have this crew ID?
    func hasCrew(_ crewID: UUID) -> Bool {
        crew.contains(where: { $0.id == crewID })
    }

    // MARK: - sample helper for previews
    static var sample: Job {
        var j = Job(
            id: UUID(),
            name: "Sample Job",
            client: "Sample Client",
            startDate: Date(),
            endDate: nil,
            days: [],
            crew: []
        )
        // create 3 sample days
        j.days = (0..<3).map { offset in
            JobDay(date: Calendar.current.date(byAdding: .day, value: offset, to: j.startDate) ?? j.startDate)
        }

        // add one crew member into job and into each day (via helper)
        let c = CrewEntry(id: UUID(), firstName: "John", lastName: "Doe", title: "Electrician", company: "ABC", email: nil, phone: nil, timeStamps: [])
        _ = j.addCrew(c)

        return j
    }

    // MARK: - convenience generator (kept for backward compatibility)
    static func generateJobDays(startDate: Date, numberOfDays: Int) -> [JobDay] {
        (0..<numberOfDays).map { offset in
            JobDay(
                date: Calendar.current.date(byAdding: .day, value: offset, to: startDate) ?? startDate,
                crew: []
            )
        }
    }

    // Hashable/Equatable by id only
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

