//
//  lostView.swift
//  WWDC24
//
//  Created by Gustavo Sena on 11/02/24.
//

import SwiftUI

struct lostView: View {
    
    @Binding var lostGame: Bool
    @Binding var heartCount: Int
    @Binding var rectangle1Position: CGPoint
    @Binding var deathCause: DeathCause
    @Binding var showGameViewOne: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack (spacing: 0) {
                
                Spacer()
                
                
                HStack(alignment: .center) {
                    
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Oh no! You crashed the ship!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(Color("sidebarDarkBlue"))
                        
                            .padding(.trailing, geometry.size.width * 0.1)
                        
                        Text(deathMessage)
                            .font(.title3)
                            .foregroundStyle(Color("sidebarDarkBlue"))
                        
                            .padding(.trailing, geometry.size.width * 0.1)
                        
                    }
                    .frame(maxWidth: geometry.size.width * 0.5)
                }
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            heartCount = 5
                            rectangle1Position = CGPoint(x: 300, y: 300)
                            lostGame.toggle()
                            showGameViewOne = true
                        }
                    }) {
                        Text("Try again!")
                            .bold()
                            .frame(maxWidth: 200, maxHeight: 60)
                            .foregroundColor(.white)
                            .background(Color("sidebarBlue"))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                    
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
            }
            .background(
                Image("lostBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .statusBarHidden(true)
        }
        
        
    }
    
    private var deathMessage: String {
        switch deathCause {
        case .leavingScreen:
            return "You got lost in the sea! Make sure to follow the buoys and don't leave the screen boundaries."
        case .collisionWithCookies:
            return "Avoid these cookies, sailor! If ye accept them, pirates lurking in the shadows can exploit yer personal information. They may use this data to bombard ye with targeted advertisements, track yer behaviour or even manipulate yer preferences. The siren call of accepting all optional cookies may be difficult to ignore, but steer your ship clear of them!"
        case .collisionWithShadySignup:
            return "Beware the murky waters of optional toggles, matey! When ye agree to receive marketing emails or to share information with third parties, ye may be surrendering yer personal data to shady characters who don't respect yer privacy. They'll sell yer information to the highest bidder, leaving ye vulnerable to relentless spam and even to potential identity theft!"
        case .collisionWithFinalBoss:
            return "Watch out for siren song of fake forms promising treasures too good to be true! When ye encounter such a trap, tread carefully, it may be a ploy to steal yer personal data. The promise of riches and pressure to accept may tempt ye to divulge every detail of yer life, from yer name and address to yer credit card and social security number. But mark me words: these scoundrels seek to exploit yer trust and do no good with your data."
        }
    }
}


#Preview {
    lostView(lostGame: .constant(true), heartCount: .constant(3), rectangle1Position: .constant(CGPoint(x: 200, y: 200)), deathCause: .constant(.collisionWithFinalBoss), showGameViewOne: .constant(false))
}
