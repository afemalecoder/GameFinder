//
//  ContentView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var genres = ["RPG", "Sandbox", "RTS", "FPS", "Simulaton", "MOBA", "ARPG", "MMORPG", "TPS", "Sport", "Puzzle", "Action", "Platform", " Adventure", "Horror", "Fighting", "Survival", "Indie"]
    @State private var currentProgress: CGFloat = 0.4
    @State private var isShowingBlue = false
    @State var selected = [String]()
    
    
    var body: some View {
        NavigationView{
        GeometryReader { geometry in
            self.generateContent(in: geometry)
            VStack{
                ZStack(alignment: .topLeading){
                    Style.ProgressBarStyle(progress: currentProgress)
                    
                }
                .padding()
                VStack(alignment: .leading){
                    Text("Choose min. 5 genres")
                        .modifier(Style.Titles())
                    
                }
                Spacer()
                HStack(){
                    Spacer()
                        Button {
                        } label: {
                            NavigationLink(destination: PlatformView()){
                                Image(systemName: "chevron.right")
                            }
                        }
                        .modifier(Style.ButtonStyle())
                    }
                .padding(.horizontal, 50)
            }
            
        }
    }
    }
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return
            ZStack{
//                Colors().backgroundColor
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                ZStack(alignment: .topLeading) {
                    ForEach(genres, id: \.self) { genre in
                        item(for: genre)
                            .padding(.vertical)
                            .padding(.horizontal)
                            .alignmentGuide(.leading, computeValue: { d in
                                if (abs(width - d.width) > g.size.width)
                                {
                                    width = 0
                                    height -= d.height
                                }
                                let result = width
                                if genre == self.genres.last! {
                                    width = 0 //last item
                                } else {
                                    width -= d.width
                                }
                                return result
                            })
                            .alignmentGuide(.top, computeValue: {d in
                                let result = height
                                if genre == self.genres.last! {
                                    height = 0 // last item
                                }
                                return result
                            })
                    }
                }
            }
        .ignoresSafeArea()
    }

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
            Text(text)
                .padding(.all, 10)
                .font(.body)
                .background(selected.contains(text) ? .blue : Colors().buttonColor)
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
