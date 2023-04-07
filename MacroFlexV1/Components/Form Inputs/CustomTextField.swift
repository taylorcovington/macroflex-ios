//
//  SwiftUIView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/4/23.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var titleText: String
    let placeholder: Text
    
    var body: some View {
        VStack {
            HStack {
                Text(titleText)
                Spacer()
            }
            .padding(.horizontal)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    placeholder
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                }
                
                HStack(spacing: 20) {
                    TextField("", text: $text)
                }
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .cornerRadius(10)
            .padding(.horizontal)
            .foregroundColor(.black)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField(text:, placeholder: Text("What is your name?"))
//    }
//}
