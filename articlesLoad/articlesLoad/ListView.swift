//
//  ListView.swift
//  articlesLoad
//
//  Created by Richard Buehling on 9/4/21.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct ListView: View {
    
    
    // Enviorement object for articles API
    @EnvironmentObject var network: Network
    
    
    // Filled with user search input
    @State var searchText = ""
    
    // Defines if user is searching or not
    @State var searching = false
    
    // Array for content that is shared
    @State var itemsTwo: [Any] = []
    
    
    // Sheet view
    class SheetManager: ObservableObject{
        @Published var showSheet = false
    }
    
    // Sheet view
    @StateObject var sheetManager = SheetManager()
    
    var body: some View {
        NavigationView {
            VStack () {
                
                
                
                // Searchbar
                SearchView(searchText: $searchText, searching: $searching)
                    .padding(.top)
                    
                // Article API data passed to a view
                List {
                    
                    //Displays and filters data for search bar
                    ForEach(network.articles.filter({"\($0)".contains(searchText) || searchText.isEmpty})) { articles in
                        
                        //Link to article
                        NavigationLink(destination: webView(url: URL(string: "https://richardbuehling.com/articles/" + articles.slug)!)) {
                            HStack(spacing: 15) {

                                VStack(alignment: .leading, spacing: 10) {
                                    Text(articles.title)
                                        .font(.subheadline)
                                        .fontWeight(.heavy)
                                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                    HStack {
                                        Text(articles.category)
                                            .font(.footnote)
                                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                        
                                        Spacer()
                                       
                                        // Share Button
                                        Button(action: {
                                            
                                            // Removes all items in itemsTwo
                                            itemsTwo.removeAll()
                                            
                                            // Appends with link to article
                                            itemsTwo.append(URL(string: "https://richardbuehling.com/articles/" + articles.slug)!)
                                            
                                            // Toggles share sheet
                                            sheetManager.showSheet.toggle()
                                            
                                            
                                        }, label: {
                                            Image(systemName: "square.and.arrow.up")
                                                .font(.footnote)
                                        })
                                      
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .frame(width: 175, height: 80, alignment: .leading)

                                // Image from API data
                                WebImage(url: URL(string: articles.image)!, options: .highPriority, context: nil)
                                    .resizable()
                                    .frame(width: 110, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .shadow(color: Color(#colorLiteral(red: 0.01905504987, green: 0.01909353398, blue: 0.01911538653, alpha: 0.3057959752)), radius: 5, x: 0.5, y: 0.1)
                                    .padding(.horizontal, 5)

                            }
                            .padding(.vertical, 15)

                        }


                    }
                }
                .onAppear {
                    
                    // Gets API data
                    network.getArticles()
                    
                    
                }
                
                // Navigation Title
                .navigationBarTitle(searching  ? "Searching" : "Ric's Articles")
                
                // Cancel button if searching
                .toolbar {
                    if searching {
                        Button("Cancel") {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                            
                        }
                    }
                }
                
                
            }
        }
        
        // Share sheet
        .sheet(isPresented: $sheetManager.showSheet, content: {
            ShareSheetTwo(itemsTwo: itemsTwo)
            
        })
    }
}

// Web view for link to article
struct webView : UIViewRepresentable {
    
    var url : URL
    
    func makeUIView(context: UIViewRepresentableContext<webView>) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<webView>) {
        
    }
}

// Share sheet
struct ShareSheetTwo : UIViewControllerRepresentable {
    
    var itemsTwo : [Any]
    
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: itemsTwo, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

// Dismisses keyboard
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// Preview for Xcode
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(Network())
    }
    
    
    
}
