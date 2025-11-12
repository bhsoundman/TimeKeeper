import SwiftUI

struct TimeStampView: View {
    @Binding var stamps: [TimeStamp]

    var body: some View {
        List {
            ForEach($stamps) { $stamp in
                HStack {
                    Text(stamp.date, style: .date)
                    Spacer()
                    TextField("Time", text: $stamp.time)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
    }
}

struct TimeStampView_Previews: PreviewProvider {
    @State static var sampleStamps = [
        TimeStamp(date: Date(), time: "08:00"),
        TimeStamp(date: Date(), time: "12:00")
    ]
    
    static var previews: some View {
        TimeStampView(stamps: $sampleStamps)
    }
}
