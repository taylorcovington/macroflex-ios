//
//  CustomWeightPicker.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/5/23.
//

import SwiftUI
import AudioToolbox

struct CustomWeightPicker: View {
    @State var offset: CGFloat = 0
    @Binding var weight: CGFloat
    
    var body: some View {
        HStack {
            Text("What is your current weight?")
            Spacer()
        }
        .padding(.horizontal)
        
        Text("\(getWeight()) lbs")
            .font(.system(size: 24, weight: .bold, design: .rounded))
        
        let pickerCount = 40
        CustomSlider(pickerCount: pickerCount, offset: $weight, content: {
            
            
            HStack(spacing: 0) {
                ForEach(1...pickerCount, id: \.self) { index in
                    VStack {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1, height: 30)
                        Text("\(95 + (index * 5))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 20)
                    
                    ForEach(1...4, id: \.self) {subIndex in
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1, height: 15)
                            .frame(width: 20)
                    }
                }
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 1, height: 30)
                    Text("\(20)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .frame(width: 20)
            }
          
        })
        .frame(height: 50)
        .overlay(
            Rectangle()
                .fill(Color.gray)
                .frame(width: 1, height: 50)
                .offset(x: 0.8, y: -30)
            
        )
        .padding()
    }
    func getWeight()->String{
        let startWeight = 100
        
        let progress = weight / 20
        
        return "\(startWeight + (Int(progress) * 1))"
    }
}

struct CustomSlider<Content: View> : UIViewRepresentable {
    
    var content: Content
    
    @Binding var offset: CGFloat
    var pickerCount: Int
    
    init(pickerCount: Int, offset: Binding<CGFloat>, @ViewBuilder content: @escaping ()->Content) {
        self.content = content()
        self._offset = offset
        self.pickerCount = pickerCount
    }
    
    func makeCoordinator() -> Coordinator {
        return CustomSlider.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        let swiftUIView = UIHostingController(rootView: content).view!
        
        let width = CGFloat((pickerCount * 5 ) * 20) + (getRect().width - 30)
        
        swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        return scrollView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: CustomSlider
        
        init(parent: CustomSlider) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.x
            
            let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
            
            scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(1157)
            
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let offset = scrollView.contentOffset.x
            
            let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
            
            scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)
            
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            AudioServicesPlayAlertSound(1157)
        }
    }
}

func getRect()->CGRect{
    return UIScreen.main.bounds
}

//struct CustomWeightPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomWeightPicker()
//    }
//}
