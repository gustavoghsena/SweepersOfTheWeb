//
//  GameViewTwo.swift
//  WWDC24
//
//  Created by Gustavo Sena on 09/02/24.

import SwiftUI

struct GameViewTwo: View {
    @Binding var rectangle1Position: CGPoint
    @Binding var showGameViewTwo: Bool
    @Binding var showGameViewThree: Bool
    @Binding var heartCount: Int
    @Binding var lostGame: Bool
    @Binding var deathCause: DeathCause
    
    @State private var isPopupVisible = true
    
    @State var cookiesShakeOffset: CGFloat = 0
    @State var signupShakeOffset: CGFloat = 0
    
    @State var hintPressed = false
    
    @State var rotationAngle: Double = 90
    
    @State var disabledCookies = false
    
    @State var disabledShadySignup = false
    
    
    @State var trackingCategories = [
        TrackingCategory(originalName: "Analytics Cookies", hintName: "Monitors your behaviour using the site", isSelected: true),
        TrackingCategory(originalName: "Performance Cookies", hintName: "Tracks users' most clicked pages", isSelected: true),
        TrackingCategory(originalName: "Targeting Cookies", hintName: "Tracks your behaviour across websites", isSelected: true),
        TrackingCategory(originalName: "Advertising Cookies", hintName: "Allows targeted ads based on behavior", isSelected: true),
        TrackingCategory(originalName: "Social Cookies", hintName: "Shares data with social platforms", isSelected: true),
        TrackingCategory(originalName: "Affiliate Cookies", hintName: "Tracks your purchases for comission", isSelected: true),
        TrackingCategory(originalName: "Location Cookies", hintName: "Monitors your location", isSelected: true),
        TrackingCategory(originalName: "Web Beacons", hintName: "Tracks your engagement with marketing campaigns", isSelected: true),

    ]


    
    
    var body: some View {
        
        
        

        @State var isAnyCategorySelected = trackingCategories.contains { $0.isSelected }
        
        
            
        GeometryReader { geometry in
            ZStack {
                NavigationSplitView(
                    columnVisibility: .constant(.doubleColumn),
                    
                    sidebar: {
                        SidebarView(rectangle1Position: $rectangle1Position,
                                    heartCount: $heartCount,
                                    hintPressed: $hintPressed,
                                    rotationAngle: $rotationAngle,
                                    showGameViewTwo: $showGameViewTwo,
                                    showGameViewThree: $showGameViewThree,
                                    disabledCookies: disabledCookies,
                                    disabledShadySignup: disabledShadySignup,
                                    disabledFinalBoss: false,
                                    checkCollision: checkCollision,
                                    geometry: geometry)
                        
                    },
                    detail: {
                        ZStack {
                            ZStack {
                                
                                Ellipse()
                                    .fill(Color.black)
                                    .opacity(0.2)
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .position(rectangle1Position)
                                
                                
                               
                                CookiesTracking(hintPressed: $hintPressed, trackingCategories: $trackingCategories, cookiesShakeOffset: $cookiesShakeOffset, disabledCookies: $disabledCookies)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.6)
                                    .position(CGPoint(x: geometry.size.width * 0.2, y: geometry.size.height * 0.7))
                                    .offset(x: cookiesShakeOffset)
                                    .opacity(disabledCookies ? 0 : 1)
                                    .animation(.easeInOut(duration: 0.5), value: disabledCookies)
                                
                                ShadySignUp(hintPressed: $hintPressed, disabledShadySignup: $disabledShadySignup, shakeOffset: $signupShakeOffset)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.7)
                                    .position(CGPoint(x: geometry.size.width * 0.55, y: geometry.size.height * 0.4))
                                    .offset(x: signupShakeOffset)
                                    .opacity(disabledShadySignup ? 0 : 1)
                                    .animation(.easeInOut(duration: 0.5), value: disabledShadySignup)
                                
                                
                                
                                let exitImage = disabledCookies && disabledShadySignup ? "buoyon" : "buoyoff"
                                
                               
                                Image(exitImage)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                                    .position(CGPoint(x: geometry.size.width * 0.55, y: geometry.size.height * 0.9))
                                    .animation(.easeInOut(duration: 0.5), value: exitImage)
                                
                               
                                Image("boat")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .rotationEffect(.degrees(rotationAngle))
                                    .position(rectangle1Position)
                                
                                
                            }
                            .background(Image("seabackground").resizable().scaledToFill())
                            .toolbar(.hidden, for: .navigationBar)
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            
                        }
                        
                        
                    }
                )
                .navigationSplitViewStyle(.balanced)
                
                if isPopupVisible {
                                               
                                            Color.black.opacity(0.5)
                                            .edgesIgnoringSafeArea(.all)
                                                               
                                        VStack {
                                           
                                            HStack {
                                                
                                                Spacer()
                                                Button(action: {
                                                   
                                                    isPopupVisible.toggle()
                                                }) {
                                                    Image(systemName: "xmark")
                                                        .foregroundColor(.white)
                                                        .fontWeight(.black)
                                                        
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            Image("binocularMan2")
                                                .resizable()
                                                .frame(maxWidth: geometry.size.height * 0.2, maxHeight: geometry.size.height * 0.2)
                                                .clipShape(Circle())

                                            
                                            Text("Aye, sailor! I spotted two traps in this area, make sure to **disable both** before we continue. **Use your binoculars to see right through them!**")
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                                .frame(maxWidth: geometry.size.width * 0.4)
                                                .padding()
                                                
                                            
                                            Spacer()
                                        }
                                        .padding(32)
                                        .frame(maxWidth: geometry.size.width * 0.5, maxHeight: geometry.size.height * 0.5)
                                        .background(Color("sidebarBlue"))
                                        .cornerRadius(10)
                                        .padding()
                                        }
            }
        }
    }
                
    
    
    func checkCollision(geometry: GeometryProxy) {
        let rect1Frame = CGRect(origin: rectangle1Position, size: CGSize(width: geometry.size.width * 0.125, height: geometry.size.width * 0.125))
        
      
        let cookiesFrame = CGRect(origin: CGPoint(x: geometry.size.width * 0.1, y: geometry.size.height * 0.5), size: CGSize(width: geometry.size.width * 0.3, height: geometry.size.height * 0.6))
        let signupFrame = CGRect(origin: CGPoint(x: geometry.size.width * 0.46, y: geometry.size.height * 0.16), size: CGSize(width: geometry.size.width * 0.28, height: geometry.size.height * 0.65))
        
      
        let winFrame = CGRect(origin: CGPoint(x: geometry.size.width * 0.55, y: geometry.size.height * 0.9), size: CGSize(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1))
        let boundsLeft = CGRect(origin: CGPoint(x: geometry.size.width * 0.01, y: geometry.size.height * 0.01), size: CGSize(width: geometry.size.width * 0.01, height: geometry.size.height))
        let boundsRight = CGRect(origin: CGPoint(x: geometry.size.width * 0.85, y: geometry.size.height * 0.01), size: CGSize(width: geometry.size.width * 0.01, height: geometry.size.height))
        let boundsTop = CGRect(origin: CGPoint(x: geometry.size.width * 0.01, y: geometry.size.height * 0.01), size: CGSize(width: geometry.size.width, height: geometry.size.height * 0.01))
        let boundsBottom = CGRect(origin: CGPoint(x: geometry.size.width * 0.01, y: geometry.size.height * 1.2), size: CGSize(width: geometry.size.width, height: geometry.size.height * 0.01))
        
      
        if !disabledCookies && rect1Frame.intersects(cookiesFrame) {
            print("Collided with cookies!")
           
            if heartCount > 1 {
                heartCount -= 1
                SoundManager.shared.play(sound: .collisionWarning)
            } else {
                SoundManager.shared.play(sound: .deathExplosion)
                showGameViewTwo = false
                lostGame = true
                deathCause = .collisionWithCookies
            }
        }
        
        
        if !disabledShadySignup && rect1Frame.intersects(signupFrame) {
            print("Collided with sign-up!")
            
            if heartCount > 1 {
                heartCount -= 1
                SoundManager.shared.play(sound: .collisionWarning)
            } else {
                SoundManager.shared.play(sound: .deathExplosion)
                showGameViewTwo = false
                deathCause = .collisionWithShadySignup
                lostGame = true
               
            }
        }
        
        if rect1Frame.intersects(winFrame) && !disabledCookies || rect1Frame.intersects(winFrame) && !disabledShadySignup {
            SoundManager.shared.play(sound: .disarmFail)
        }
        else if rect1Frame.intersects(winFrame) && disabledCookies && disabledShadySignup {
            print("Collided with winFrame!")
            changeScreen()
        } else if rect1Frame.intersects(boundsLeft) || rect1Frame.intersects(boundsRight) || rect1Frame.intersects(boundsTop) || rect1Frame.intersects(boundsBottom) {
            
            if heartCount > 1 {
                heartCount -= 1
            } else {
                showGameViewTwo = false
                deathCause = .leavingScreen
                lostGame = true
            }
            
            print(heartCount)
            print("Collided with screen bounds!")
        }
    }
    


    func changeScreen() {
        SoundManager.shared.play(sound: .winBanjo)
          showGameViewTwo = false
          showGameViewThree = true
          rectangle1Position = CGPoint(x: 100, y: 150)
      }
    
    
}

//#Preview {
//    GameViewTwo()
//}

