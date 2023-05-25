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
    
    //temporary
    @AppStorage("onboarding") var isOnboarding: Bool?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
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
                    welcomeText()
                    
                    todayView(router: router)
                    
                    todaysProgressView(router: router)
                    Button("reset onboarding") {
                        isOnboarding = true
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
//            .toolbar {
//                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
//                    
//                    Image(systemName: "person.crop.circle")
//                        .resizable()
//                        .foregroundColor(.secondary)
//                        .frame(width: 30, height: 30)
//                        .onTapGesture {
//                            router.showScreen(.push) { router in
//                                AccountView()
//                            }
//                        }
//                    
//                }
//            }
        }
     
    }
}

struct welcomeText: View {
    
//    @StateObject private var viewModel = DashboardViewModel()
//    @AppStorage(Settings.firstNameKey) var firstName: String?
    @AppStorage("name") var currentUsersName: String?
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
//                Text("\(viewModel.currentDay.displayFormat)")
                    Text("Today April 7th")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color(Colors.mfBluePrimary))
//                Text("\(viewModel.greetingText), \(firstName ?? 👋")
                Text("Welcome, \(currentUsersName ?? "friend") 👋")
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
//        Text("Today's Schedule")
//            .font(.system(size: 18, weight: .bold, design: .rounded))
            
        VStack(spacing: 4) {
                            
            Text("Todays' Workout")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(Color(Colors.mfBluePrimary))
            Text("Greek God - Workout A")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
            
            Text("Average workout time: 52 mins")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            
            ButtonView(title: "Start workout", verticalPadding: 10.0, isFullWidth: false) {
                router.showScreen(.fullScreenCover) { router in
                    ExerciseView()
                }
                
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(25)
        .padding(30)
        .overlay(
               RoundedRectangle(cornerRadius: 8)
                .stroke(Color(Colors.mfBluePrimary), lineWidth: 2)
          
        )
     
    }
}

struct todaysProgressView: View {
    let router: AnyRouter
    
    @ObservedObject var viewModelSteps = DashboardViewModel(activity: Activity.allActivities()[0])
    @ObservedObject var viewModelWeight = DashboardViewModel(activity: Activity.allActivities()[1])
    
    var body: some View {
        Text("Today's Progress")
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .padding(.top, 20)
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                VStack {
                    Image("runningshoe")
                        .resizable()
                        .frame(width: 100, height: 100)
                     
                    Text("\(viewModelSteps.healthStatToday)")
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
                     
                    Text("\(viewModelWeight.todaysWeight, specifier: "%.1f")")
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
            
            VStack {
                Image("sleepingmask")
                    .resizable()
                    .frame(width: 75, height: 75)
                 
                Text("7 hrs 52 min")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                Text("Sleep Time")
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
            VStack {
//                GifImage("emojibar")
                Image("emojibar")
                    .resizable()
                    .frame(width: 75, height: 75)
                 
                Text("Energized")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                Text("Today's mood")
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
