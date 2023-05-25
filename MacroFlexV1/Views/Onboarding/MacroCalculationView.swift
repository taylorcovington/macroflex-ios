//
//  MacroCalculationView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/3/23.
//

import SwiftUI
import SwiftfulRouting

struct MacroCalculationView: View {
    let router: AnyRouter
    
    @AppStorage("onboarding") var isOnboarding: Bool?
    
    var body: some View {
        VStack {
            
            HStack {
                Text("We've calculated your macros!")
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            
            VStack {
                ZStack {
                    // totalCalories
                    Circle()
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.cyan]),
                            startPoint: .leading,
                            endPoint: .trailing), lineWidth: 10)
                    // carbs
                    Circle()
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .padding(16)
//                                       protein
                    Circle()
                        .trim(from: 0, to: 0.20)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: -90))
                        .padding(16)
                    // fat
                    Circle()
                        .trim(from: 0, to: 0.25)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: -10))
                        .padding(16)
                  

                }
                .frame(width: 150, height: 150)

                }
                .frame(width: 200, height: 200)
            
            VStack(alignment: .center) {

//  MARK: Macro Breakdown
                VStack(spacing: 10) {
                    Text("Your Macro Breakdown")
                        .font(.headline)
                    VStack {
//
//                        Text(Double(macro.totalCalories!)?.formatted() ?? "")
                        Text("2441")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.cyan)
                        Text("Total Calories")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.secondary)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .cornerRadius(25)
                    .padding()
                    .foregroundColor(.black)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    HStack {
                        VStack {
//                            Text(Double(macro.protein!)?.formatted() ?? "")
                            Text("160")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                            Text("Protein")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .cornerRadius(25)
                        .padding()
                        .foregroundColor(.black)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        VStack {
//                            Text(Double(macro.fats!)?.formatted() ?? "")
                            Text("67")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.green)
                            Text("Fats")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .cornerRadius(25)
                        .padding()
                        .foregroundColor(.black)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        VStack {
//                            Text(Double(macro.carbs!)?.formatted() ?? "")
                            Text("292")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.yellow)
                            Text("Carbs")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .cornerRadius(25)
                        .padding()
                        .foregroundColor(.black)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    }
                    Button("Use my own macros") {
                        router.showModal(transition: .move(edge: .bottom), animation: .spring(), alignment: .center, backgroundColor: Color.gray.opacity(0.35), useDeviceBounds: false) {
                            Text("Sample")
                                .frame(width: 275, height: 450)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .onTapGesture {
                                    router.dismissModal()
                                }
                        }
                    }
                    .padding()
                }
            
            
            Spacer()
            ButtonView(title: "Go to dashboard 🚀") {
                isOnboarding = false
                router.showScreen(.fullScreenCover) { router in
                    DashboardView(router: router)
                }
            }
            .padding(.bottom, 15)
        }
        .navigationTitle("Your Macros")
        .padding(.horizontal)
    }
       
}

struct MacroCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            MacroCalculationView(router: router)
        }
    }
}
