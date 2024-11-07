//
//  CookiesTracking.swift
//  WWDC24
//
//  Created by Gustavo Sena on 09/02/24.
//

import SwiftUI

struct CookiesTracking: View {
    
    @Binding var hintPressed: Bool
    @Binding var trackingCategories: [TrackingCategory]
    @Binding var cookiesShakeOffset: CGFloat
    @Binding var disabledCookies: Bool
    
    var body: some View {
        let backgroundColor: Color = hintPressed ? .white : Color("veryDarkGray")
        let textColor: Color = hintPressed ? .black : .white
        
        let title = hintPressed ? "Will you allow us to track your every move on the web?" : "Do you accept our delicious homemade cookies? 🍪"
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.bottom)
                .foregroundColor(textColor)
            
            ScrollView {
                ForEach(trackingCategories.indices, id: \.self) { index in
                    HStack {
                        Text(hintPressed ? trackingCategories[index].hintName : trackingCategories[index].originalName)
                            .foregroundColor(textColor)
                        Spacer()
                        Image(systemName: trackingCategories[index].isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(trackingCategories[index].isSelected ? .green : .gray)
                            .onTapGesture {
                                trackingCategories[index].isSelected.toggle()
                            }
                        Rectangle()
                            .frame(maxWidth: 10)
                            .opacity(0)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    toggleAllCategories(true)
                }) {
                    Text("Accept All")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(uiColor: .systemGray2))
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    if trackingCategories.filter({ !$0.isSelected }).count == trackingCategories.count {
                        disabledCookies = true
                        SoundManager.shared.play(sound: .disarmedTrap)
                    } else {
                        SoundManager.shared.play(sound: .disarmFail)
                        shakeComponent()
                        
                    }
                }) {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .frame(maxWidth: 100)
                }
            }
        }
        .padding(20)
        .foregroundColor(textColor)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 5)
        .offset(x: cookiesShakeOffset)
    }
    
     func toggleAllCategories(_ isSelected: Bool) {
        trackingCategories.indices.forEach { index in
            trackingCategories[index].isSelected = isSelected
        }
    }
    
     func shakeComponent() {
        withAnimation {
            cookiesShakeOffset = 10
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.easeInOut(duration: 0.1)) {
                cookiesShakeOffset = -10
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut(duration: 0.1)) {
                cookiesShakeOffset = 0
            }
        }
    }
}



#Preview {
    CookiesTracking(hintPressed: .constant(false), trackingCategories: .constant([
        TrackingCategory(originalName: "Analytics Cookies", hintName: "Analytics", isSelected: true),
        TrackingCategory(originalName: "Advertising Cookies", hintName: "Advertising", isSelected: true),
        TrackingCategory(originalName: "Performance Cookies", hintName: "Performance", isSelected: true),
        TrackingCategory(originalName: "Session Cookies", hintName: "Session", isSelected: true),
        TrackingCategory(originalName: "Persistent Cookies", hintName: "Persistent", isSelected: true),
        TrackingCategory(originalName: "Third-party Cookies", hintName: "Third-party", isSelected: true),
        TrackingCategory(originalName: "Social Cookies", hintName: "Social", isSelected: true),
        TrackingCategory(originalName: "Marketing Cookies", hintName: "Marketing", isSelected: true),
        TrackingCategory(originalName: "Preference Cookies", hintName: "Preference", isSelected: true),
        TrackingCategory(originalName: "Geo-Targeting Cookies", hintName: "Geo-Targeting", isSelected: true),
        TrackingCategory(originalName: "Conversion Tracking Cookies", hintName: "Conversion Tracking", isSelected: true),
        TrackingCategory(originalName: "Affiliate Tracking Cookies", hintName: "Affiliate Tracking", isSelected: true),
        TrackingCategory(originalName: "Behavioral Targeting Cookies", hintName: "Behavioral Targeting", isSelected: true),
    ]), cookiesShakeOffset: .constant(0), disabledCookies: .constant(false))
}
