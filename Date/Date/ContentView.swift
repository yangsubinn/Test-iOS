//
//  ContentView.swift
//  Date
//
//  Created by 양수빈 on 2023/08/17.
//

import SwiftUI

extension Date {
    static func now() -> Date {
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        let now =  calendar.date(from: component)!
        return now
    }
}

struct ContentView: View {
    
    @State var text: Date = Date.now()
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("\(text)")
            
            Button("Date()") {
                text = Date()
                print(Date())
            }
            
            Button("Date(KST)") {
                let timezone = TimeZone.autoupdatingCurrent
                let secondsFromGMT = timezone.secondsFromGMT(for: Date())
                let localizedDate = Date().addingTimeInterval(TimeInterval(secondsFromGMT))
                text = localizedDate
                print(localizedDate)
            }
            
            Button("DateFormatter(KST)") {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "KST")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                dateFormatter.string(from: Date())
                let date = dateFormatter.string(from: Date())
                print(date)
            }
            
            Button("Calendar") {
                let calendar = Calendar.current
                let component = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
                text = calendar.date(from: component)!
            }
            
            // 안됨
            Button("Calendar(KST)") {
                var calendar = Calendar.current
                calendar.locale = Locale(identifier: "KO")
                calendar.timeZone = TimeZone.autoupdatingCurrent
                let component = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
                text = calendar.date(from: component)!
            }
            
            DatePicker("", selection: $text,
                       in: Date.now()...Date.now().addingTimeInterval(24 * 60 * 60),
                       displayedComponents: [.date, .hourAndMinute])
            .environment(\.locale, Locale(identifier: "ko_KR"))
            .labelsHidden()
            .datePickerStyle(.wheel)
                
        }
        .frame(maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
