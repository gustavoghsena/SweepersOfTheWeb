//
//  OnboardingView.swift
//  WWDC24
//
//  Created by Gustavo Sena on 09/02/24.
//


import SwiftUI

struct OnboardingView: View {
    @State var selectedTab = 0
    @Binding var showOnboarding: Bool
    @Binding var showGameViewOne: Bool
    
    var body: some View {
        VStack (spacing: 0) {
            TabView(selection: $selectedTab) {
                HStack(alignment: .center) {
                
                    
                    Spacer()
                    
                    Text("Ahoy there, matey! Welcome aboard to the digital seas! Listen up, **as an eager new sailor in our crew, ye be settin' sail on a journey like no other**. \n \nPicture this: the internet, a vast ocean filled with cat videos and endless streams of knowledge. It's like a magical net that connects us all in ways our ancestors could never fathom.")
                        .font(.title2)
                        .foregroundStyle(Color("sidebarDarkBlue"))
                        .frame(maxWidth: 600)
                        .padding(.trailing, 96)
                       
                   
                }
                .background(
                    Image("onboarding1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .tag(0)
                
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("Now, as with any great adventure, there be treacherous waters ahead. Beware of them rascals and scallywags lurkin' in the depths! **They be usin' the same tech that brings us joy and knowledge to plunder our privacy and lead us astray.** \n \nAye, them be using the **deceptive patterns**, like cunning pirates' cannons to steal our digital booty.")
                        .font(.title2)
                        .foregroundStyle(Color("sidebarDarkBlue"))
                        .frame(maxWidth: 600)
                        .padding(.trailing, 96)
                        .padding(.bottom, 96)
                       
                   
                }
                .background(
                    Image("onboarding2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .tag(1)
                
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text("But fear not, for every sea has its heroes! And just like them brave sailors on deck, we be embarkin' on a crucial mission. **Our job? To disarm the traps set by these bad people, akin to disarming old mines in the sea.** \n \nWith every touch, we be treadin' carefully, sweepin' the digital waters clean of deception. **Together, we sail toward a brighter horizon!**")
                        .font(.title2)
                        .foregroundStyle(Color("sidebarDarkBlue"))
                        .frame(maxWidth: 600)
                        .padding(.trailing, 96)

                       
                   
                }
                .background(
                    Image("onboarding3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            let buttonLabel: String = selectedTab == 2 ? "Let's go!" : "Next"
            
            Button(action: {
                withAnimation {
                    
                    if selectedTab >= 2 {
                        showOnboarding = false
                        showGameViewOne = true
                        SoundManager.shared.pause(sound: .backgroundSong, fadeOutDuration: 3)
                        print("Onboarding complete")
                    } else {
                        selectedTab = min(selectedTab + 1, 2) 
                    }
                }
            }) {
                Text(buttonLabel)
                    .bold()
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .foregroundColor(.white)
                    .background(Color("sidebarBlue"))

                    
                  
            }
        }
        .ignoresSafeArea()
    }
}

