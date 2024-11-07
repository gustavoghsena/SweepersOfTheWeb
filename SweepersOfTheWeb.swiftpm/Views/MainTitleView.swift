//
//  MainTitleView.swift
//  WWDC24
//
//  Created by Gustavo Sena on 15/02/24.
//

import SwiftUI

struct MainTitleView: View {
    
    @Binding var showOnboarding: Bool
    
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Image("seabackground")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 600)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    
                    Button(action: {
                        withAnimation {
                            showOnboarding = true
                        }
                    }) {
                        Text("PLAY")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .frame(maxWidth: 400)
                            .padding()
                            .background(Color("sidebarBlue"))
                            .cornerRadius(72)
                            .shadow(color: Color("sidebarDarkBlue"), radius: 20, x: 0, y: 0)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "lock.rotation")
                            .font(.title)
                            .foregroundStyle(.white)
                        
                        Text("Please ensure that your device is **locked in landscape mode and with sound enabled!**")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        
                    }
                    .padding(.bottom, 12)
                }
            }
            .onAppear(perform: {
                SoundManager.shared.playLoop(sound: .backgroundSong)
            })
        }

    }
        
}


