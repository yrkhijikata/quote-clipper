//
//  ContentView.swift
//  quoteClipper
//
//  Created by Yuriko Hijikata on 8/5/21.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
        @State private var recognizedText = "Please tap 'Start Scanning'."
        @State private var showingScanningView = false
        @State var quotes:[String] = UserDefaults.standard.stringArray(forKey: "quotes") ?? []
        @State var textTapped:Bool = false
        @State var startedScanning:Bool = false
      
        let minDragTranslationForSwipe: CGFloat = 50
        let numTabs = 2
        
        @State private var selection = 0
        init() {
            let navBarAppearance = UINavigationBar.appearance()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    var body: some View {
                TabView(selection: $selection){
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color("Color11"), Color("Color12")]), startPoint: .leading, endPoint: .topTrailing).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        VStack {
                            (Text("QuoTe\nCLippeR") + Text(Image(systemName: "scissors")))
                                .foregroundColor(.white)
                                .font(.custom("PlayfairDisplay-Bold", size: 50))
                                .frame(width: 350)
                                .padding(.top, 50)
                            
                            ZStack {
                                TextEditor(text:$recognizedText)
                                    .padding(30)
                                    .background(Color.white)
                                    .frame(width: 350, height: 400)
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        self.textTapped = true
                                    }
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        self.textTapped = false
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        
                                    }, label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .imageScale(.large)
                                            .padding()
                                            .foregroundColor(.black)
                                    })
                                    .padding().position(x: 336, y: 22)
                                    .opacity(self.textTapped ? 1 : 0)
                                }
                            }
                            Spacer()
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    print(self.recognizedText)
                                    if startedScanning && self.recognizedText != ""{
                                        print()
                                        quotes.append(self.recognizedText)
                                        UserDefaults.standard.set(self.quotes, forKey: "quotes")
                                        self.recognizedText = "Please tap 'Start Scanning'."
                                        self.startedScanning = false
                                        self.selection = 1
                                    }
                                }) {
                                    Text("Save Quote")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Capsule().fill(Color.black))
                                Spacer()
                                Button(action: {
                                    self.showingScanningView = true
                                    self.startedScanning = true
                                }) {
                                    Text("Start Scanning")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Capsule().fill(Color.black))
                                Spacer()
                                
                            }
                            .padding(.bottom, 50)
                            
                            Spacer()
                            
                        }
                        .sheet(isPresented: $showingScanningView) {
                            
                            ScanDocumentView(recognizedText: self.$recognizedText)
                        }
                    }
                    .onTapGesture {
                        self.textTapped = false
                        self.endTextEditing()
                    }
                    .tabItem {
                        Image(systemName: "doc.text.viewfinder")
                        Text("Scan")
                    }.tag(0)
                    VStack {
                        QuoteListView(quoteList: $quotes)
                    }
                        .tabItem {
                            Image(systemName: "doc.text")
                            Text("Quotes")
                        }.tag(1)
                }
            }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
