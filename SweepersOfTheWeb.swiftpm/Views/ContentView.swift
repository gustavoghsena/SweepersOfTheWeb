//
//  ContentView.swift
//  WWDC24
//
//  Created by Gustavo Sena on 09/02/24.

import SwiftUI

struct ContentView: View {
    @State var rectangle1Position = CGPoint(x: 300, y: 300)
    
    @State var showGameViewOne = false
    @State var showGameViewTwo = false
    @State var showGameViewThree = false
    @State var showOnboarding = false
    @State var showWinView = false
    
    @State var heartCount = 5
    @State var lostGame = false
    @State var deathCause: DeathCause = .leavingScreen
    
    var body: some View {
        
       
        if showOnboarding {
            OnboardingView(showOnboarding: $showOnboarding, showGameViewOne: $showGameViewOne)
        } else if showGameViewOne {
            GameViewOne(rectangle1Position: $rectangle1Position, showGameViewOne: $showGameViewOne, showGameViewTwo: $showGameViewTwo, showGameViewThree: $showGameViewThree, heartCount: $heartCount, lostGame: $lostGame, deathCause: $deathCause)
        } else if showGameViewTwo {
            GameViewTwo(rectangle1Position: $rectangle1Position, showGameViewTwo: $showGameViewTwo, showGameViewThree: $showGameViewThree, heartCount: $heartCount, lostGame: $lostGame, deathCause: $deathCause)
        } else if showGameViewThree {
            GameViewThree(rectangle1Position: $rectangle1Position, showGameViewTwo: $showGameViewTwo, showGameViewThree: $showGameViewThree, showWinView: $showWinView, heartCount: $heartCount, lostGame: $lostGame, deathCause: $deathCause)
        } else if showWinView {
            winView(showWinView: $showWinView)
        } else if lostGame {
            lostView(lostGame: $lostGame, heartCount: $heartCount, rectangle1Position: $rectangle1Position, deathCause: $deathCause, showGameViewOne: $showGameViewOne)
        } else {
            MainTitleView(showOnboarding: $showOnboarding)
        }
        
    }
        
        
}

