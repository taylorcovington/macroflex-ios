//
//  CustomDatePicker.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI
import SwiftfulRouting

struct CustomDatePicker: View {
    let router: AnyRouter
    @State var date: Date
    var body: some View {
        LazyVStack {
//            HStack {
//                Text("What is your birthday?")
//                Spacer()
//            }
            DatePicker("What is your birthday?", selection: $date, displayedComponents: .date)
//                .padding(10)
//                .labelsHidden()
                
        }
    }
}

//
//struct CustomDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomDatePicker(date: Date())
//    }
//}

//{
    
//}
//.padding(10)
//.labelsHidden()
//.datePickerStyle(WheelDatePickerStyle())
