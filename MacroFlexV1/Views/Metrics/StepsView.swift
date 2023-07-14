//
//  StepsView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 3/31/23.
//

import SwiftUI
import Charts
import SwiftfulRouting

struct StepsView: View {
    let router: AnyRouter
    @State private var stepCount = ""
    @State private var selectedDate = Date()
    @ObservedObject var viewModel = DashboardViewModel.shared
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            
            VStack {
                Image("runningshoe")
                    .resizable()
                    .frame(width: 100, height: 100)
                 
                Text("\(viewModel.healthStatToday)")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                Text("of 10,000 goal")
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(25)
            .padding(10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
           
            VStack(alignment: .leading){
                HStack(alignment: .bottom) {
                    Text("\(Int(round(viewModel.healthData.reduce(0, { $0 + $1.stat! }) / 7)))")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("average last 7 days")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
                Chart {
    //                TODO: Update this with users actual goal
                    RuleMark(y: .value("Goal", 10000))
                        .foregroundStyle(Color.mint)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
    //                    .annotation(alignment: .leading) {
    //                        Text("Goal")
    //                            .font(.caption)
    //                            .foregroundColor(.secondary)
    //                    }
                    ForEach(viewModel.healthData) { step in
                        BarMark(
                            x: .value("Date", step.date, unit: .day),
                            y: .value("Steps", step.stat!)
                        )
                        .foregroundStyle(Color(Colors.mfBluePrimary).gradient)
                    }
                }
                .frame(height: 200)
                .chartXAxis {
                    AxisMarks(values: viewModel.healthData.map { $0.date }) { date in
                        AxisValueLabel(format: .dateTime.day(), centered: true)
                    }
                }
                .padding(.bottom)
                .onAppear {
                    for (index,_) in viewModel.healthData.enumerated(){
                        withAnimation(.easeInOut(duration: 0.8).delay(Double(index) * 0.05)) {
                            index
                        }
                    }
                }
                
                HStack {
                    Image(systemName: "line.diagonal")
                        .rotationEffect(Angle(degrees: 45))
                        .foregroundColor(.mint)
                    Text("Goal")
                        .foregroundColor(.secondary)
                }
                
//                MARK: Start of list
                VStack(alignment: .leading, spacing: 15) {
                    Text("Steps data")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .padding()
                    
                    ForEach(viewModel.healthData) { step in
                        HStack {
                            Text("\(step.date.displayFormat)")
                            Spacer()
                            Text("\(Int(round(step.stat ?? 0)))")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text("steps")
                                .font(.system(size: 12, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("Steps")
        .padding()
        }
        .navigationBarItems(trailing:

          Button("Add Data") {
            Button("Resizable Sheet") {
                router.showResizableSheet(
                    sheetDetents: [.medium, .large],
                    selection: nil,
                    showDragIndicator: true) { router in
                        MyView(router: router)
                    }
            }
//                Text("Sample")
//                    .frame(width: 275, height: 450)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//                    .onTapGesture {
//                        router.dismissModal()
//                    }
                
               
                
            
        }
       )
    }
}

struct MyView: View {
    @State private var stepCount = ""
    @State private var selectedDate = Date()
    let router: AnyRouter
    
    
    var body: some View {
        VStack {
            Text("Add Steps")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .padding()
            TextField("Steps", text: $stepCount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                .padding()
            HStack {
                Button("Cancel") {
                    router.dismissModal()
                }
                .padding()
                Spacer()
                Button("Add") {
                    
                }
            }
        }
    }
}

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            StepsView(router: router)
        }
    }
}
