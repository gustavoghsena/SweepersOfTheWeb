//
//  ShadySignUp.swift
//  WWDC24
//
//  Created by Gustavo Sena on 10/02/24.
//

import SwiftUI

struct ShadySignUp: View {
    @State var acceptedTerms = true
    @State private var subscribedToNewsletter = true
    @State private var allowSellingData = true
    
    @Binding var hintPressed: Bool
    @Binding var disabledShadySignup: Bool
    @Binding var shakeOffset: CGFloat
    
    var body: some View {
        let backgroundColor: Color = hintPressed ? .white : Color("veryDarkGray")
        let textColor: Color = hintPressed ? .black : .white
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Text("Sign Up")
                    .font(.title)
                    .bold()
                    .foregroundColor(textColor)
                Spacer()
            }
            
            Text("Email:")
                .foregroundColor(textColor)
            
            HStack {
                Text(verbatim: "sailor@navsweeper.com")
                    .foregroundColor(textColor)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
            
            Text("Password:")
                .foregroundColor(textColor)
            
            HStack {
                Text("••••••••••")
                    .foregroundColor(textColor)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
            
            VStack(alignment: .leading) {
                
                Toggle(isOn: $acceptedTerms) {
                    Text(hintPressed ? "The only thing you must accept" : "Accept terms of use")
                        .foregroundColor(textColor)
                }
                Toggle(isOn: $subscribedToNewsletter) {
                    Text(hintPressed ? "You'll be bombarded with spam" : "Subscribe to our updates")
                        .foregroundColor(textColor)
                }
                
                Toggle(isOn: $allowSellingData) {
                    Text(hintPressed ? "We'll sell your data SO HARD! 🤑" : "Share data with our partners")
                        .foregroundColor(textColor)
                }
            }
            .padding(.top, 12)
            
            Button(action: signUp) {
                Text("Sign Up")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding(20)
        .foregroundColor(textColor)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 5)
    }
    
    func signUp() {
        if acceptedTerms && !subscribedToNewsletter && !allowSellingData {
            disabledShadySignup = true
            SoundManager.shared.play(sound: .disarmedTrap)
        } else {
            SoundManager.shared.play(sound: .disarmFail)
            shakeComponent()
            disabledShadySignup = false
        }
    }
    
    private func shakeComponent() {
        withAnimation {
            shakeOffset = 10
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation(.easeInOut(duration: 0.1)) {
                shakeOffset = -10
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut(duration: 0.1)) {
                shakeOffset = 0
            }
        }
    }
}


        



#Preview {
    ShadySignUp(hintPressed: .constant(false), disabledShadySignup: .constant(false), shakeOffset: .constant(CGFloat(0)))
}
