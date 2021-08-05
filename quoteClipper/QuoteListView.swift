//
//  QuoteListView.swift
//  quoteClipper
//
//  Created by Yuriko Hijikata on 8/5/21.
//

import SwiftUI

struct QuoteListView: View {
   
    @Binding var quoteList: [String]
    
    var body: some View {
        
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("GPink"), Color("GBlue")]), startPoint: .leading, endPoint: .topTrailing).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    
                    ScrollView{
                        List{
                            Text("CliPped QuoTes")
                                .foregroundColor(.black)
                                .font(.custom("PlayfairDisplay-Bold", size: 40))
                                
                                .padding()
                            
                            
                            ForEach(quoteList, id:\.self) {
                                quoteText in
                                NavigationLink(
                                    destination: QuoteView(quote:quoteText),
                                    label: {
                                        Image(systemName: "quote.bubble")
                                        Text(quoteText)
                                            .foregroundColor(.black)
                                            .padding()
                                            .lineLimit(1)
                                        
                                        
                                    })
                                
                            }.onDelete(perform: { indexSet in
                                quoteList.remove(atOffsets: indexSet)
                                UserDefaults.standard.set(self.quoteList, forKey: "quotes")
                                
                            })
                        }
                        .frame(maxWidth: 350, minHeight: 600)
                        .cornerRadius(25)
                        Spacer()
                    }
                }
                
            }
            
            
            
            
        }
        
    }
}

struct QuoteListView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteListView(quoteList: .constant(["Brute, et tu!!", "this is a long text that i wannt to save for eternity hehehehehe", "this is another example of quote and i cannot thing of anything clever to say here"]))
    }
}

