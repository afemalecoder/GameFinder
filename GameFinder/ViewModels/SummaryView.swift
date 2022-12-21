//
//  SummaryView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 14/12/2022.
//

import SwiftUI

struct SummaryView: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    private var text: String
    
    init(_ text: String) {
        self.text = text
    }
    private func determineTruncation(_ geometry: GeometryProxy) {
        
        let total = self.text.boundingRect(with: CGSize(width: geometry.size.width, height: .greatestFiniteMagnitude),
                                           options: .usesLineFragmentOrigin,
                                           attributes: [.font: UIFont.systemFont(ofSize: 20)],
                                           context: nil)
        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }
    var body: some View {
        VStack(alignment: .trailing, spacing: 3) {
            Text(self.text)
                .font(.system(size: 20))
                .lineLimit(self.expanded ? nil : 10)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })
            if self.truncated {
                withAnimation(.easeIn){
                    self.toggleButton
                        
                }
                
            }
        }
    }
    var toggleButton: some View {
        Button(action: { self.expanded.toggle() }) {
            Text(self.expanded ? "Show less" : "Show more")
                .font(.caption)
        }
    }
}
