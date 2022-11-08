//
//  SignupView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI
import Firebase

struct SignupView: View {
    @State private var currentProgress = 1.0
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var userName = ""
    @EnvironmentObject var signup: AuthService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.presentationMode) private var dismiss
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                Colors().backgroundColor
                
                VStack(spacing: 20){
                    Spacer()
                    ZStack(alignment: .topLeading){
                        Style.ProgressBarStyle(progress: currentProgress)
                    }
                    .padding()
                    
                    VStack(){
                        Text("Almost there,")
                            .modifier(Style.Titles())
                        Text("Register to find your next game")
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        VStack(){
                            Spacer()
                            VStack{
                                TextField("Name", text: $userName)
                                    .modifier(Style.textFieldStyle())
                                                            
                                TextField("Email", text: $userEmail)
                                    .modifier(Style.textFieldStyle())
                                                                 
                                SecureField("Password", text: $userPassword)
                                    .modifier(Style.textFieldStyle())
                           
                            }
                            
                            if !signup.errorMessage.isEmpty {
                                Text("Error: \(signup.errorMessage)")
                                    .foregroundColor(.red)
                            }
                            Spacer()
                            NavigationLink(destination: GameFinderView(), isActive: $signup.registerd){EmptyView()}
                            Button{
                                signup.registerUser(userEmail: userEmail, userPassword: userPassword)
                            }label: {
                                Text("Register")
                            }
                            .disabled(!userEmail.isEmpty && !userPassword.isEmpty ? false : true)
                            .modifier(Style.largeButtonStyle())
                            
                            Button{}
                        label: {
                            NavigationLink(destination: LoginView()){
                                Text("Login instead?")
                            }
                        }
                        }
                        .padding()
                        .frame(width: .infinity, height: 500)
                        .background(Colors().secondaryBackgroundColor)
                        .cornerRadius(20)
                        Spacer()
                    }
                    HStack(){
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .modifier(Style.ButtonStyle())
                        Spacer()
                    }
                    .padding([.bottom, .leading])
                }
                .padding()
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
