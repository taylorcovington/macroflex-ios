//
//  CustomTabView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/27/23.
//

import SwiftUI
import SwiftfulRouting

struct CustomTabView: View {
    let router: AnyRouter
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            ZStack {
                TabView {
                    DashboardView(router: router, authViewModel: AuthViewModel())
                        .tabItem {
                            Image(systemName: "list.clipboard.fill")
                            Text("Today")
                        }
                        
                    MacrosView()
                        .tabItem {
                            Image(systemName: "chart.pie")
                            Text("Macros")
                        }
                    Spacer()
                    ExerciseView()
                        .tabItem{
                            Image(systemName: "dumbbell")
                            Text("Exercise")
                        }
                    ProgressView()
                        .tabItem{
                            Image(systemName: "chart.bar.xaxis")
                            Text("Progress")
                        }
                    
                    
                }
                .padding(.vertical)
                VStack {
                    Spacer()
                    HStack {
                        AddButton(router: router)
                    }
                    .padding(.bottom, 30)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
       
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            CustomTabView(router: router, authViewModel: AuthViewModel())
        }
    }
}
