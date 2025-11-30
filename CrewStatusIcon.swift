// MARK: - Crew Status Icon
struct CrewStatusIcon: View {
    let status: JobDetailView.AssignmentStatus
    
    var body: some View {
        switch status {
        case .none:
            Image(systemName: "circle")
                .foregroundColor(.blue)
        case .someDays:
            Image(systemName: "minus.circle.fill")
                .foregroundColor(.blue)
        case .allDays:
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.blue)
        }
    }
}