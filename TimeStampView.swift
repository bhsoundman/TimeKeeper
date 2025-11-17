import SwiftUI

struct TimeStampView: View {
    @Binding var timeStamps: [TimeStamp]

    var body: some View {
        List {
            ForEach($timeStamps) { $stamp in
                HStack {
                    Text(stamp.type.rawValue.capitalized)
                        .frame(width: 80, alignment: .leading)
                    Text(stamp.date.formatted(date: .numeric, time: .omitted))
                        .frame(width: 120, alignment: .leading)
                    Text(stamp.time.formatted(date: .omitted, time: .shortened))
                        .frame(width: 80, alignment: .leading)
                }
            }
            .onDelete(perform: deleteStamp)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Time Stamps")
    }

    private func deleteStamp(at offsets: IndexSet) {
        timeStamps.remove(atOffsets: offsets)
    }
}

struct TimeStampView_Previews: PreviewProvider {
    @State static var sampleTimeStamps = [
        TimeStamp(id: UUID(), date: Date(), time: Date(), type: .start),
        TimeStamp(id: UUID(), date: Date(), time: Date(), type: .end)
    ]

    static var previews: some View {
        NavigationStack {
            TimeStampView(timeStamps: $sampleTimeStamps)
        }
    }
}
