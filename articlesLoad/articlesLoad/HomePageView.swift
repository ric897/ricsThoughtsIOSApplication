//
//  HomePageView.swift
//  articlesLoad
//
//  Created by Richard Buehling on 9/5/21.
//

import SwiftUI

struct HomePageView: View {
    
    
    
    // App data for onboarding screen
    @AppStorage("currentPage") var currentPage = 0
    
    // Onboarding screen
    @State var sheet = false
    
    
    
    
    var body: some View {
        // Tab View
        TabView {
            ShareImage()
                .tabItem {
                    Image(systemName: "quote.bubble")
                    Text("Quote")
                }
            ListView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Articles")
                }
        }
        .onAppear {
            
            
            // Checks if it is user's first time using app
            if currentPage == 0 {
                sheet = true
                currentPage += 1
            }
        }

        // Onboarding Screen
        .sheet(isPresented: $sheet, content: {
            VStack(spacing: 25) {
                Text("Welcome to Ric's Thoughts.")
                    .font(.title)
                    .fontWeight(.bold)
                

                
                Text("A hub where a stream of quotes and articles can be consumed and shared to motivate you and anyone you wish to share the content to.")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("Every day a new quote will be generated. This quote can be shared over text, snapchat, instagram, etc.")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("You can also read articles that are centered around motivation, mental health, tech, finance, and all things personal improvement.")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 50)
                
                // Dismisses onboarding screen
                Button(action: {
                    sheet = false
                }, label: {
                    HStack {
                        Text("Let's Go")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Image(systemName: "arrow.right")
                    }
                    
                })
                
            }
        
        })
        }
    }

// Preview for Xcode
struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(Network())
            .environmentObject(networkTwo())
    }
}
