//
//  winView.swift
//  WWDC24
//
//  Created by Gustavo Sena on 18/02/24.
//

import SwiftUI

struct winView: View {
    
    @Binding var showWinView: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack (spacing: 0) {
                
                Spacer()
                
                
                HStack(alignment: .center) {
                    
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("You did it, matey!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(Color("sidebarDarkBlue"))
                        
                            .padding(.trailing, geometry.size.width * 0.1)
                        
                        Text("**That was a lot of disabled traps for your first day!** But, remember, the internet is a big place. There are many more deceptive patterns out there. Keep your guard up and stay safe!")
                            .font(.title2)
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
                            showWinView = false
                        }
                    }) {
                        Text("Go back to main menu")
                            .bold()
                            .frame(maxWidth: 240, maxHeight: 60)
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
                Image("wonBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .onAppear {
                SoundManager.shared.play(sound: .backgroundSong, fadeInDuration: 1)
            }
            .statusBarHidden(true)
        }
        
        
    }
}

#Preview {
    winView(showWinView: .constant(true))
}
