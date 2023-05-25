//
//  CustomWeightPickerV1.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/11/23.
//

import SwiftUI

struct CustomWeightPickerV1: View {
    @Binding var weight: String
    @Binding var weightType: String
    
    var options = ["lbs", "kgs"]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        LazyVStack {
            HStack {
                Text("What is your current weight?")
                Spacer()
            }
            // TextField to add decimal
            // selector to choose weight type
            HStack {
                ZStack(alignment: .leading) {
                        TextField("", text: $weight)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                Button("done") {
                                    dismiss()
                                }
                            }
                        }
                            .keyboardType(.decimalPad)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .cornerRadius(10)
                .foregroundColor(.black)
                
                Picker("", selection: $weightType) {
                    ForEach(options, id: \.self) {option in
                        Text(option).tag(option)
                       
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}
//
//struct CustomWeightPickerV1_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomWeightPickerV1(weight: )
//    }
//}
