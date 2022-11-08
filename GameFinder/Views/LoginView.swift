//
//  LoginView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 07/11/2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var userEmail = ""
    @State private var userPassword = ""
    @EnvironmentObject var loginSignup: AuthService

    
    var body: some View {
        NavigationStack{
            ZStack{
                Colors().backgroundColor
               
                VStack(spacing: 20){
                    Image("gameFinder")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    VStack(){
                        Text("Welcome back,")
                            .modifier(Style.Titles())
                        Text("Login and find your next game")
                            .font(.title3)
                            .foregroundColor(.white)
                        VStack(){
                            Spacer()
                            VStack{
                                TextField("Email", text: $userEmail)
                                    .modifier(Style.textFieldStyle())
                                
                                SecureField("Password", text: $userPassword)
                                    .modifier(Style.textFieldStyle())
                            }
                            if !loginSignup.errorMessage.isEmpty {
                                Text("Error: \(loginSignup.errorMessage)")
                                    .foregroundColor(.red)
                            }
                            
                            Spacer()
                            NavigationLink(destination: GameFinderView(), isActive: $loginSignup.loggedIn){EmptyView()}
                            Button{
                                loginSignup.loginUser(userEmail: userEmail, userPassword: userPassword)
                            }label: {
                                Text("Log in")
                            }
                            .disabled(!userEmail.isEmpty && !userPassword.isEmpty ? false : true)
                            .modifier(Style.largeButtonStyle())
                            
                            Button{}
                        label: {
                            NavigationLink(destination: SignupView()){
                                Text("Signup instead?")
                            }
                        }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: .infinity, height: 500)
                    .background(Colors().secondaryBackgroundColor)
                    .cornerRadius(20)
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
