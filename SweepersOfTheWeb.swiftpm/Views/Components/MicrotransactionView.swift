//
//  MicrotransactionView.swift
//  WWDC24
//
//  Created by Gustavo Sena on 18/02/24.
//

import SwiftUI

struct MicrotransactionView: View {
    
    @Binding var hintPressed: Bool
    @Binding var shakeOffset: CGFloat
    @Binding var disabledFinalBoss: Bool
    
    @State var geometry: GeometryProxy
    
    @State var showingNaggingPopup: Bool = false
    @State var showingSecondNaggingPopup: Bool = false
    @State var showingLegalPopup: Bool = false
    
    @State  var countdown: Int = 60
    @State  var timer: Timer?
    @State  var countdownText: String = ""


    @State  var fullName: String = ""
    @State  var socialSecurityNumber: String = ""
    @State  var age: String = ""
    @State  var homeAddress: String = ""
    @State  var creditCardDetails: String = ""

    let dealConditionsText = "By electing to engage with the functionality herein denominated as 'Unlock now!', hereinafter referred to as the 'Transaction Mechanism', you, henceforth designated as the 'User', hereby affirmatively manifest your consent and binding agreement to adhere to the comprehensive and exhaustive terms and conditions delineated herewith.\n\nThe User acknowledges and unequivocally accepts that the utilization of the Transaction Mechanism entails a contractual relationship with the entity offering the aforementioned service, hereby identified as the 'Provider', and consequently agrees to be irrevocably bound by the stipulations elucidated within this legally binding instrument.\n\nPursuant to the utilization of the Transaction Mechanism, the User expressly recognizes and comprehends that the Provider may, at its sole discretion and without any obligation to obtain further consent or authorization from the User, engage in the commercialization and monetization of the User's personal data, inclusive of but not limited to demographic information, behavioral data, browsing history, and any other data voluntarily or involuntarily provided by the User during the course of interaction with the Transaction Mechanism. The User explicitly consents to the collection, processing, storage, and dissemination of said personal data by the Provider and any affiliated entities or third-party service providers, for the purposes of targeted advertising, market research, product development, and any other lawful or legitimate business activities deemed appropriate by the Provider.\n\nFurthermore, by proceeding with the activation of the Transaction Mechanism, the User acknowledges and accepts the imposition of a recurring charge, hereinafter denominated as the 'Subscription Fee', which shall be automatically debited from the User's designated financial instrument, such as but not limited to a credit card, debit card, or any other form of electronic payment method, on a periodic basis as determined by the Provider. The User hereby grants explicit authorization and consent for the Provider to initiate recurring charges against the aforementioned financial instrument, without requiring any additional notice, confirmation, or approval from the User, until such time as the User elects to terminate the subscription in accordance with the procedures outlined in the subsequent sections herein.\n\nIt is incumbent upon the User to carefully review and fully comprehend the terms and conditions contained herein prior to engaging with the Transaction Mechanism. By proceeding with the activation of the Transaction Mechanism, the User signifies their acknowledgment, understanding, and unequivocal acceptance of all provisions contained within this document. Should the User find any aspect of these terms objectionable or disagreeable, the User is hereby advised to abstain from utilizing the Transaction Mechanism and to promptly terminate any ongoing engagement with the Provider's services.\n\nThe User hereby acknowledges and agrees that their consent to the terms and conditions delineated herein shall constitute a legally binding agreement between the User and the Provider, and that any breach or violation of these terms may result in the imposition of legal consequences, including but not limited to the termination of services, financial penalties, and any other remedies available under applicable laws and regulations.\n\nIn consideration of the foregoing, the User hereby affirms their voluntary assent to the terms and conditions set forth herein, and hereby affixes their electronic signature as evidence of their explicit consent and agreement to be bound thereby."
    



    var body: some View {
        
        let headlineText: String = hintPressed ? "This is a huge trap, there is even a subscription fee buried in here 🫣" : "Unlock the ending faster! Just let us know you a little better 😁"
        
        let dealinfoText: String = hintPressed ? "These are often purposefully hard to read, because they don't want you to" : "By unlocking the ending, I agree to applicable terms of the deal"
        
        let acceptButtonText: String = hintPressed ? "Give away your money and data 💸" : "Unlock now!"
        
        let refuseButtonText: String = hintPressed ? "No, thanks. I can do this alone." : "I prefer to never know the true ending 🤪"
        
        let backgroundColor: Color = hintPressed ?  .white : Color("veryDarkGray")
        let textColor: Color = hintPressed ? .black : .white
        let placeholderTextColor: Color = hintPressed ? Color.black : .white
        let textFieldColor: Color = hintPressed ?  Color(uiColor: .systemGray).opacity(0.7) : Color(UIColor.darkGray)
        
        VStack {
                    VStack {
                        Text(countdownText)
                            .font(.title2)
                            .bold()
                            .onAppear {
                                startCountdown()
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .foregroundColor(.white)
                    .background(.red)
                    
                    Spacer()
                    
                   
                    VStack {
                        
                        Text(headlineText)
                            .foregroundStyle(textColor)
                            .font(.title)
                            .bold()
                            .padding(32)
                    }
                    
                    ZStack {
                        
                        ScrollView {
                            
                            VStack(spacing: 16) {
                                VStack(alignment: .leading) {
                                    Text("Full Name")
                                        .font(.headline)
                                    
                                    TextField("", text: $fullName, prompt: Text("Enter your full name").foregroundColor(placeholderTextColor))
                                        .padding()
                                        .background(textFieldColor)
                                        .cornerRadius(8)
                                        .disabled(true)
                                }
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Social Security Number")
                                            .font(.headline)
                                        
                                        TextField("", text: $socialSecurityNumber, prompt: Text("Enter your SSN").foregroundColor(placeholderTextColor))
                                            .padding()
                                            .background(textFieldColor)
                                            .cornerRadius(8)
                                            .disabled(true)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("Age")
                                            .font(.headline)
                                        
                                        TextField("", text: $age, prompt: Text("Enter your age").foregroundColor(placeholderTextColor))
                                            .padding()
                                            .background(textFieldColor)
                                            .cornerRadius(8)
                                            .disabled(true)
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Home Address")
                                        .font(.headline)
                                    
                                    TextField("", text: $homeAddress, prompt: Text("Enter your full address").foregroundColor(placeholderTextColor))
                                        .padding()
                                        .background(textFieldColor)
                                        .cornerRadius(8)
                                        .disabled(true)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Credit Card Number")
                                        .font(.headline)
                                    
                                    TextField("", text: $creditCardDetails, prompt: Text("Enter your credit card number").foregroundColor(placeholderTextColor))
                                        .padding()
                                        .background(textFieldColor)
                                        .cornerRadius(8)
                                        .disabled(true)
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                
                
                if hintPressed {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.regularMaterial)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(radius: 8)
                            .padding(.horizontal, 16)
                        
                    }
                    
                    Text("DON'T")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .frame(maxHeight: geometry.size.height * 0.6)
            

            .foregroundStyle(textColor)
            
        
            
            Spacer()
            
         
            VStack {
                Button(action: {
                    showingLegalPopup.toggle()
                }) {
                    Text(dealinfoText)
                        .font(.footnote)
                        .padding(8)
                        .foregroundStyle(hintPressed ? Color.blue : Color(uiColor: .systemGray))
                }
                
                
       
                Button(action: {
                    shakeComponent()
                    SoundManager.shared.play(sound: .disarmFail)
                    
                }) {Text(acceptButtonText)
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .font(.title3)
                .bold()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
              
                Button(refuseButtonText) {
                    showingNaggingPopup.toggle()
                }
                .padding(.bottom)
                .foregroundStyle(hintPressed ? Color.blue : Color(uiColor: .systemGray))
                .cornerRadius(10)
            }
            .padding(.horizontal, 32)
        }
        .background(backgroundColor)
        .ignoresSafeArea()
       
        .sheet(isPresented: $showingLegalPopup) {
            VStack {
                ScrollView {
                    Text(dealConditionsText)
                        .padding(32)
                }
                Button("Close") {
                    showingLegalPopup.toggle()
                }
                .padding()
                .foregroundColor(.red)
            }
        }
      
        .sheet(isPresented: $showingNaggingPopup) {
            VStack {
                Text("Actually, you changed your mind and will unlock the ending now, right? 😁")
                    .font(.title)
                    .bold()
                
                HStack {
                    Button("Yes") {
                       
                        shakeComponent()
                        SoundManager.shared.play(sound: .disarmFail)
                        showingNaggingPopup.toggle()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("No") {
                
                        showingSecondNaggingPopup.toggle()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
            } .padding(32)
            .sheet(isPresented: $showingSecondNaggingPopup) {
                VStack {
                    
                    Text("Last chance! Do you accept to unlock it now?")
                        .font(.title)
                        .bold()
                    
                    Button("YES") {
                        shakeComponent()
                        SoundManager.shared.play(sound: .disarmFail)
                        showingNaggingPopup.toggle()
                    }
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("no") {
                        showingNaggingPopup.toggle()
                        disabledFinalBoss = true
                        SoundManager.shared.play(sound: .disarmedTrap)
                    }
  
                    .foregroundColor(Color(uiColor: .systemGray4))
                    .cornerRadius(10)
                   
                }
                .padding(32)
            }
        }
        
    }
    


    private func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
                countdownText = "TIME IS RUNNING OUT: \(formattedTime(countdown))"
            } else {
                timer?.invalidate()
                countdownText = "Just kidding, take your time!" 
            }
        }
    }

    private func formattedTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
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






//#Preview {
//    MicrotransactionView()
//}
