//
//  GameViewThree.swift
//  WWDC24
//
//  Created by Gustavo Sena on 18/02/24.
//

import SwiftUI

struct GameViewThree: View {
    @Binding var rectangle1Position: CGPoint
    @Binding var showGameViewTwo: Bool
    @Binding var showGameViewThree: Bool
    @Binding var showWinView: Bool
    @Binding var heartCount: Int
    @Binding var lostGame: Bool
    @Binding var deathCause: DeathCause
    
    @State private var isPopupVisible = true
    @State var finalbossShakeOffset: CGFloat = 0
    @State var disabledFinalBoss = false
    
    @State var hintPressed = false
    
    @State var rotationAngle: Double = 90
    


    
    
    var body: some View {
        
        
            
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
                                    disabledCookies: false,
                                    disabledShadySignup: false, 
                                    disabledFinalBoss: disabledFinalBoss,
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
                                
                                
                            
                                
                                MicrotransactionView(hintPressed: $hintPressed, shakeOffset: $finalbossShakeOffset, disabledFinalBoss: $disabledFinalBoss, geometry: geometry)
                                    .background()
                                    .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.6)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .position(CGPoint(x: geometry.size.width * 0.375, y: geometry.size.height * 0.5))
                                    .padding()
                                    .offset(x: finalbossShakeOffset)
                                    .opacity(disabledFinalBoss ? 0 : 1)
                                    .animation(.easeInOut(duration: 0.5), value: disabledFinalBoss)
                              
                                
                                let exitImage = disabledFinalBoss ? "buoyon" : "buoyoff"
                        
                                
                      
                                Image(exitImage)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                                    .position(CGPoint(x: geometry.size.width * 0.675, y: geometry.size.height * 0.4))

                                
                               
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
                                            
                                            Image("binocularMan3")
                                                .resizable()
                                                .frame(maxWidth: geometry.size.height * 0.2, maxHeight: geometry.size.height * 0.2)
                                                .clipShape(Circle())

                                            
                                            Text("Oh, this is a tricky one! You're almost there, sailor. Watch out for things that are too good to be true and **pay attention to the details**. You can do it!")
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
        
        let finalbossFrame = CGRect(origin: CGPoint(x: geometry.size.width * 0.22, y: geometry.size.height * 0.15), size: CGSize(width: geometry.size.width * 0.45, height: geometry.size.height * 0.6))
        
        
        let winFrame = CGRect(origin: CGPoint(x: geometry.size.width * 0.675, y: geometry.size.height * 0.4), size: CGSize(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1))
        
        let boundsLeft = CGRect(origin: CGPoint(x: geometry.size.width * 0.01, y: geometry.size.height * 0.01), size: CGSize(width: geometry.size.width * 0.01, height: geometry.size.height))
        let boundsRight = CGRect(origin: CGPoint(x: geometry.size.width * 0.85, y: geometry.size.height * 0.01), size: CGSize(width: geometry.size.width * 0.01, height: geometry.size.height))
        let boundsTop = CGRect(origin: CGPoint(x: geometry.size.width * 0.01, y: geometry.size.height * 0.01), size: CGSize(width: geometry.size.width, height: geometry.size.height * 0.01))
        let boundsBottom = CGRect(origin: CGPoint(x: geometry.size.width * 0.01, y: geometry.size.height * 1.2), size: CGSize(width: geometry.size.width, height: geometry.size.height * 0.01))
        
        if !disabledFinalBoss && rect1Frame.intersects(finalbossFrame) {
            print("Collided with final boss!")
            
            if heartCount > 1 {
                heartCount -= 1
                SoundManager.shared.play(sound: .collisionWarning)
            } else {
                SoundManager.shared.play(sound: .deathExplosion)
                showGameViewThree = false
                deathCause = .collisionWithFinalBoss
                lostGame = true
                
            }
        }
        
      
        if rect1Frame.intersects(winFrame) && disabledFinalBoss {
            print("Collided with winFrame!")
            changeScreen()
        } else if rect1Frame.intersects(boundsLeft) || rect1Frame.intersects(boundsRight) || rect1Frame.intersects(boundsTop) || rect1Frame.intersects(boundsBottom) {
            
            if heartCount > 1 {
                heartCount -= 1
                SoundManager.shared.play(sound: .collisionWarning)
            } else {
                SoundManager.shared.play(sound: .deathExplosion)
                showGameViewThree = false
                deathCause = .leavingScreen
                lostGame = true
                
            }
            
            print(heartCount)
            print("Collided with screen bounds!")
        }
    }
    


    func changeScreen() {
//        SoundManager.shared.play(sound: .winBanjo)
          showGameViewThree = false
          showWinView = true
          rectangle1Position = CGPoint(x: 150, y: 150)
      }
    
    
}

//#Preview {
//    GameViewThree()
//}
