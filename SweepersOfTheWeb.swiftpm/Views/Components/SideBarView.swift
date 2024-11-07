//
//  SideBarView.swift
//  WWDC24
//
//  Created by Gustavo Sena on 10/02/24.
//
import SwiftUI

struct SidebarView: View {
    
    @Binding var rectangle1Position: CGPoint
    
    @Binding var heartCount: Int
    @Binding var hintPressed: Bool
    @Binding var rotationAngle: Double
    
   
    @Binding var showGameViewTwo: Bool
    @Binding var showGameViewThree: Bool
    
    var disabledCookies: Bool
    var disabledShadySignup: Bool
    
    var disabledFinalBoss: Bool
    
    var checkCollision: (GeometryProxy) -> Void
    var geometry: GeometryProxy
    
   
    
    var body: some View {
        VStack(spacing: 22) {
            
            HStack {
                Image("sailor")
                    .resizable()
                    .frame(maxWidth: geometry.size.height * 0.07, maxHeight: geometry.size.height * 0.07)
                    .clipShape(Circle())
                    .padding(.leading, 8)
                
               
                    HStack(spacing: 4) {

                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: index < heartCount ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(index < heartCount ? .red : .white)
                        }
                    }
                    .padding(.trailing, 8)
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.08)
            .padding(8)
            .foregroundColor(.black)
            .background(Color("sidebarDarkBlue"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
          
            
       
            
            VStack {
               
                HStack {
                    if showGameViewTwo == true {
                        
                        if disabledCookies && disabledShadySignup {
                            Spacer()
                            Spacer()
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .font(Font.system(size: 60, weight: .bold))
                            Text("Area is clear! Get to\nthat buoy, sailor.")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                            
                        } else {
                            Spacer()
                            Spacer()
                            Spacer()
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(Font.system(size: 52, weight: .bold))
                                .foregroundStyle(.yellow)
                            Text("Clear all traps before proceeding!")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                               
                                
                        }
                        
                        
                    } else if showGameViewThree {
                        
                        if disabledFinalBoss {
                            Spacer()
                            Spacer()
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .font(Font.system(size: 60, weight: .bold))
                            Text("Area is clear! Get to\nthat buoy, sailor.")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                            
                        } else {
                            Spacer()
                            Spacer()
                            Spacer()
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(Font.system(size: 52, weight: .bold))
                                .foregroundStyle(.yellow)
                            Text("Clear all traps before proceeding!")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                        }
                    } else {
                        Spacer()
                        Spacer()
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .font(Font.system(size: 60, weight: .bold))
                        Text("Area is clear! Get to\nthat buoy, sailor.")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.15)
            .foregroundStyle(.white)
            .background(Color("sidebarDarkBlue"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            if showGameViewTwo || showGameViewThree {
                VStack {
                    Button(action: {
                       
                        withAnimation {
                            hintPressed.toggle()
                        }
                        
                    }) {
                        Image(systemName: "binoculars.fill")
                            .font(Font.system(size: 52, weight: .bold))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(hintPressed ? Color.red : Color.green)
                    .foregroundColor(Color.black.opacity(0.5))
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.125)
                .foregroundStyle(.black)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
      
            
            VStack(spacing: 0) {
                
                
                Button(action: {
                   
                    withAnimation {
                        rectangle1Position.y -= 15
                        checkCollision(geometry)
                        rotationAngle = 0
                    }
                }) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.title2)
                       
                }
                .frame(width: 60, height: 60)
                .background(Color.white)
                .foregroundColor(Color("sidebarDarkBlue"))
                .clipShape(Circle())
                .buttonRepeatBehavior(.enabled)
                
                HStack (spacing: 16) {
                    Spacer()
                    
                    Button(action: {
                      
                        withAnimation {
                            rectangle1Position.x -= 20
                            checkCollision(geometry)
                            rotationAngle = -90
                        }
                    }) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                    }
                    .foregroundColor(Color("sidebarDarkBlue"))
                    .clipShape(Circle())
                    .buttonRepeatBehavior(.enabled)
                    
    
                    
                    Spacer()
                    
                    
                    Button(action: {
                       
                        withAnimation {
                            rectangle1Position.x += 20
                            checkCollision(geometry)
                            rotationAngle = 90
                        }
                    }) {
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                    }
                    .foregroundColor(Color("sidebarDarkBlue"))
                    .clipShape(Circle())
                    .buttonRepeatBehavior(.enabled)
                    
                    Spacer()
                }
                
                Button(action: {
                    
                    withAnimation {
                        rectangle1Position.y += 20
                        checkCollision(geometry)
                        rotationAngle = 180 
                    }
                }) {
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                }
                .foregroundColor(Color("sidebarDarkBlue"))
                .clipShape(Circle())
                .buttonRepeatBehavior(.enabled)
                
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.25)
            .padding(.vertical, geometry.size.height * 0.025)
            .foregroundStyle(.black)
            .background(Color("sidebarDarkBlue"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(.hidden, for: .navigationBar)
        .background(Color("sidebarBlue"))
    }
}




//#Preview {
//    SidebarView()
//}
