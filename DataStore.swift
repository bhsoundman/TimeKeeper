//
//  DataStore.swift
//  TimeKeeper
//

import Foundation
import SwiftUI
import Combine

// MARK: - DataStore

class DataStore: ObservableObject {
    
    // MARK: Published properties
    @Published var crewMembers: [CrewMember] = []
    @Published var jobs: [Job] = []
    @Published var archivedCrewMembers: [CrewMember] = []


    // MARK: Initialization
    init() {
        loadCrewMembers()
        loadJobs()
    }

    // MARK: Crew Members
    
    func loadCrewMembers() {
        guard let crewData = UserDefaults.standard.data(forKey: "crewMembers") else { return }
        do {
            let savedCrew = try JSONDecoder().decode([CrewMember].self, from: crewData)
            self.crewMembers = savedCrew
        } catch {
            print("Failed to decode crewMembers: \(error)")
        }
    }
    
    func saveCrewMembers() {
        do {
            let crewData = try JSONEncoder().encode(crewMembers)
            UserDefaults.standard.set(crewData, forKey: "crewMembers")
        } catch {
            print("Failed to encode crewMembers: \(error)")
        }
    }

    func addCrewMember(_ crew: CrewMember) {
        crewMembers.append(crew)
        saveCrewMembers()
    }

    func updateCrewMember(_ crew: CrewMember) {
        if let index = crewMembers.firstIndex(where: { $0.id == crew.id }) {
            crewMembers[index] = crew
            saveCrewMembers()
        }
    }

    func removeCrewMember(_ crew: CrewMember) {
        if let index = crewMembers.firstIndex(where: { $0.id == crew.id }) {
            crewMembers.remove(at: index)
            saveCrewMembers()
        }
    }

    // MARK: Jobs
    
    func loadJobs() {
        guard let jobData = UserDefaults.standard.data(forKey: "jobs") else { return }
        do {
            let savedJobs = try JSONDecoder().decode([Job].self, from: jobData)
            self.jobs = savedJobs
        } catch {
            print("Failed to decode jobs: \(error)")
        }
    }
    
    func saveJobs() {
        do {
            let jobData = try JSONEncoder().encode(jobs)
            UserDefaults.standard.set(jobData, forKey: "jobs")
        } catch {
            print("Failed to encode jobs: \(error)")
        }
    }
    
    func addJob(_ job: Job) {
        jobs.append(job)
        saveJobs()
    }
    
    func updateJob(_ job: Job) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index] = job
            saveJobs()
        }
    }
    func deleteJob(at offsets: IndexSet) {
        jobs.remove(atOffsets: offsets)
        saveJobs()
    }

    func removeJob(_ job: Job) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs.remove(at: index)
            saveJobs()
        }
    }
}

