import SwiftUI

struct TimeStampView: View {
    @Binding var timeStamps: [TimeStamp]

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(timeStamps) { stamp in
                HStack {
                    Text(stamp.type.rawValue.capitalized)
                        .font(.subheadline)
                        .foregroundColor(stamp.type == .clockIn ? .green : .red)
                    Spacer()
                    Text(stamp.date, style: .time)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Divider()
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct TimeStampView_Previews: PreviewProvider {
    @State static var sampleStamps: [TimeStamp] = [
        TimeStamp(type: .clockIn, date: Date()),
        TimeStamp(type: .clockOut, date: Date().addingTimeInterval(3600))
    ]

    static var previews: some View {
        TimeStampView(timeStamps: $sampleStamps)
            .previewLayout(.sizeThatFits)
    }
}
