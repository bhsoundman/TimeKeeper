// CrewMemberManager.swift

import Foundation

class CrewMemberManager {
    private var crewMembers: [CrewMember] = []

    // Add a new crew member to the global roster
    func addCrewMember(_ crewMember: CrewMember) {
        crewMembers.append(crewMember)
    }

    // Remove a crew member from the global roster
    func removeCrewMember(_ crewMember: CrewMember) {
        if let index = crewMembers.firstIndex(of: crewMember) {
            crewMembers.remove(at: index)
        }
    }

    // Get the list of all crew members
    func getAllCrewMembers() -> [CrewMember] {
        return crewMembers
    }
}