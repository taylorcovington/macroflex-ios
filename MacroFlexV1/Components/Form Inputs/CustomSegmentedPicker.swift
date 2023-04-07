//
//  CustomPicker.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/4/23.
//

import SwiftUI

struct CustomSegmentedPicker: View {
    
    @Binding var selection: String
    var title: String
    var optionsArray: [String]
    
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
            }
            Picker("", selection: $selection) {
                ForEach(optionsArray, id: \.self) {option in
                    Text(option).tag(option)
                   
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
}

//struct CustomPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomPicker()
//    }
//}
