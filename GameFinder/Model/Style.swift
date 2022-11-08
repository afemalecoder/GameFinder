//
//  Style.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import Foundation
import SwiftUI

class Style {
    
    struct ProgressBarStyle: View {
        var progress: Double
        var body: some View {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 20)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .frame(width: 300 * progress, height: 20)
        }
    }
    
    struct ButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .bold()
                .padding(30)
                .background(.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
        }
    }
    
    struct largeButtonStyle: ViewModifier{
        func body(content:Content) -> some View {
            content
                .frame(width: 200, height: 20)
                .font(.title2)
                .bold()
                .padding(20)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
    }
    
    struct textFieldStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: 300, height: 50)
                .background(.white)
                .cornerRadius(20)
                .foregroundColor(.black)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
    }
    
    struct Card: ViewModifier {
        var texts: String
        func body(content: Content) -> some View {
            ZStack{
                content
                    .frame(width: .infinity, height: 120)
                    .foregroundColor(Color(red: 49 / 255, green: 49 / 255, blue: 125 / 255))
                    .cornerRadius(20)
                    .opacity(0.3)
                HStack{
                    VStack{
                        Text(texts)
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                    }
                }
            }
        }
    }
    
    struct Titles: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.title)
                .bold()
                .foregroundColor(.white)
        }
    }
}
