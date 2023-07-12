//
//  ConnectView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/12/23.
//

import SwiftUI
import SwiftfulRouting

struct ConnectView: View {
    let router: AnyRouter
    
    let healthStore = HealthStore()
    var body: some View {
            VStack {
                Spacer()
                HStack(spacing: 30) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Connect to Apple Health")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                        Text("MacroFlex can read and write your weight, sleep, exercise times, macros, and more from your Apple Health")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(.secondary)
                        
                        Button("Connect") {
                            healthStore.requestAuth()
                        }
                        .frame(maxWidth: 120, minHeight: 55)
                        .background(.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .padding(.top, 10)
                    }
                }
                .padding()
                Spacer()
                HStack {
                    ButtonView(title: "Next") {
                        router.showScreen(.push) { router in
                            BioView(router: router)
                        }
                    }
                }
                .padding()
               
            }
            .navigationTitle("Optionally sync your data")
    }
}

struct ConnectView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            ConnectView(router: router)
        }
    }
}
