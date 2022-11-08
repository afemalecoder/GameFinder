//
//  PlatformView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/11/2022.
//

import SwiftUI

struct PlatformView: View {
    @State private var currentProgress = 0.7
    @State private var isShowingBlue = false
    @State var selected = [String]()
    @State private var platforms = ["Playstation 5", "Xbox", "PC", "Switch", "Mobile", "Playstation 4"]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.presentationMode) private var dismiss
    
    func item(for text: String) -> some View {
        Button{
            if selected.contains(text){
                if let index = selected.firstIndex(of: text){
                    selected.remove(at: index)
                }
                isShowingBlue.toggle()
            } else {
                selected.append(text)
            }
        }
    label: {
        Rectangle()
            .background(selected.contains(text) ? .blue : Color(red: 28 / 255, green: 30 / 255, blue: 84 / 255))
            .modifier(Style.Card(texts: text))
    }
        
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Colors().backgroundColor
                    ScrollView{
                        VStack{
                            VStack(){
                                ForEach(platforms, id: \.self) { platform in
                                    item(for: platform)
                                }
                                .padding(10)
                            }
                            .padding(.vertical, 130)
                        }
                    }
                    .overlay(alignment: .top){
                        VStack{
                            ZStack(alignment: .topLeading){
                                Style.ProgressBarStyle(progress: currentProgress)
                            }
                            Text("Pick your platform(s)")
                                .modifier(Style.Titles())
                        }
                        .padding(.vertical, 60)
                    }
                    .overlay(alignment: .bottom){
                        ZStack{
                            HStack(){
                                Button {
                                    self.presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "chevron.left")
                                }
                                .modifier(Style.ButtonStyle())
                                
                                Spacer()
                                Button {
                                } label: {
                                    NavigationLink(destination: SignupView()){
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                .modifier(Style.ButtonStyle())
                            }
                            .padding([.horizontal, .vertical], 30)
                        }
                    
                    }
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView()
    }
}
