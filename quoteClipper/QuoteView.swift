//
//  QuoteView.swift
//  quoteClipper
//
//  Created by Yuriko Hijikata on 8/5/21.
//

import SwiftUI

struct QuoteView: View {
    var quote:String
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                
                ScrollView{
                    Text("\"\(quote)\"")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: 350, minHeight: 350)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color("GPink"), Color("GBlue")]), startPoint: .leading, endPoint: .topTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = self.quote
                            }) {
                                Text("Copy to clipboard")
                                Image(systemName: "doc.on.doc")
                            }
                        }
                }
            }
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(quote: "Rome was not built in a day. Heard of this phrase?")
        
    }
}

