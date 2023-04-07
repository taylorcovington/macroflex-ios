//
//  DashboardView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI
import SwiftfulRouting

struct DashboardView: View {
    let router: AnyRouter
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                VStack(alignment: .leading) {
                    welcomeText()
                    
                    todayView(router: router)
                    
                    todaysProgressView(router: router)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .foregroundColor(.secondary)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        router.showScreen(.push) { router in
                            AccountView()
                        }
                    }
                
            }
        }
    }
}

struct welcomeText: View {
    
//    @StateObject private var viewModel = DashboardViewModel()
//    @AppStorage(Settings.firstNameKey) var firstName: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
//                Text("\(viewModel.currentDay.displayFormat)")
                    Text("Today April 7th")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color(Colors.mfBluePrimary))
//                Text("\(viewModel.greetingText), \(firstName ?? 👋")
                Text("Welcome, Taylor")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .padding(.bottom)
            }
            Spacer()
        }
    }
}

struct todayView: View {
    let router: AnyRouter
    var body: some View {
        Text("Today's Schedule")
            .font(.system(size: 20, weight: .bold, design: .rounded))
            
        VStack() {
            Text("Todays' Workout")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color(Colors.mfBluePrimary))
            Text("Greek God - Workout A")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
            
            Text("Average workout time: 52 mins")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            
            Button("Start workout") {
                router.showScreen(.fullScreenCover) { router in
                    ExerciseView()
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(25)
        .padding(30)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct todaysProgressView: View {
    let router: AnyRouter
    var body: some View {
        Text("Today's Progress")
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .padding(.top, 20)
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                VStack {
                    Image("runningshoe")
                        .resizable()
                        .frame(width: 100, height: 100)
                     
                    Text("2,549")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("Steps")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(25)
                .padding(10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .onTapGesture {
                    router.showScreen(.push) { router in
                        StepsView()
                    }
                }
            
        
                VStack {
                    Image("weightscale")
                        .resizable()
                        .frame(width: 75, height: 75)
                     
                    Text("158.9")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("Weight")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(25)
                .padding(10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .onTapGesture {
                    router.showScreen(.push) { router in
                        WeightTrackingView()
                    }
                }
            
          
                VStack {
                    Image("waterbottle")
                        .resizable()
                        .frame(width: 75, height: 75)
                     
                    Text("85oz")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("Water Intake")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(25)
                .padding(10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .onTapGesture {
                    router.showScreen(.push) { router in
                        WaterIntakeView()
                    }
                }
            
            
                VStack {
                    Image("stopwatch")
                        .resizable()
                        .frame(width: 75, height: 75)
                     
                    Text("52 min")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("Workout Time")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(25)
                .padding(10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .onTapGesture {
                    router.showScreen(.fullScreenCover) { router in
                        ExerciseView()
                    }
                }
            
           
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            DashboardView(router: router)
        }
    }
}
