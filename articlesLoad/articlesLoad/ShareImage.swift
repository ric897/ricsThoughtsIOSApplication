//
//  ShareSheet.swift
//  articlesLoad
//
//  Created by Richard Buehling on 9/6/21.
//

import SwiftUI

struct ShareImage: View {
    
    
    
    // Enviorment Object for Quotes API
    @EnvironmentObject var networkQuotes: networkTwo
    
    // Array for content that is shared
    @State var items: [Any] = []

    // Sheet view
    class SheetManager: ObservableObject{
        @Published var showSheet = false
    }
    
    // Sheet view
    @StateObject var sheetManager = SheetManager()
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            // Quote API data passed into view
            ForEach(networkQuotes.quotes) {quotes in
                
                VStack {
                    VStack (spacing: 25) {
                        
                        
                        Text(quotes.q)
                            .font(.title)
                            .fontWeight(.bold)
                        Text("- " + quotes.a)
                        
                    }
                    .padding()
                }
            }

            // Share Button
            Button(action: {
                
                // Removes all items from items array
                items.removeAll()
                
                // Appends with rendered image from the "snapshot" function
                items.append(testView.snapshot())
                
                // Toggle the showSheet variable that shows the share sheet
                sheetManager.showSheet.toggle()
                
                
            }, label: {
                
                Image(systemName: "square.and.arrow.up")
                    .font(.headline)
            })
            
            Spacer()
            
            HStack {
                
                // Attribution to ZenQoutes API
                Text("Inspirational Quotes Provided by:")
                    .font(.footnote)
                    .opacity(0.1)
                Link(destination: URL(string: "https://zenquotes.io/")!, label: {
                    Text("ZenQuotes API")
                        .font(.footnote)
                        .foregroundColor(Color("Color"))
                        .opacity(0.1)
                        
                })
            }
            .padding()
            
           
        }
        .onAppear {
            // Gets the API data
            networkQuotes.getQuotes()
        }
        
        // Share sheet
        .sheet(isPresented: $sheetManager.showSheet, content: {
            ShareSheet(items: items)
            
        })
        
    }
    
    // View that is rendered and shared
    var testView: some View {
        VStack {
            ForEach(networkQuotes.quotes) {quotes in
                
                VStack {
                    VStack (spacing: 25) {
                        
                        
                        VStack {
                            Text(quotes.q)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("- " + quotes.a)
                                .foregroundColor(.white)
                        }
                        .padding()
                            
                            
                        
                            
                        
                    }
                    .frame(width: 500, height: 500, alignment: .center)
                    .background(Color(.black))
                }
            }
           
            
       }
    }
}

// Share sheet code
struct ShareSheet : UIViewControllerRepresentable {
    
    var items : [Any]
    
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

// Preview for Xcode
struct ShareImage_Previews: PreviewProvider {
    static var previews: some View {
        ShareImage()
            .environmentObject(networkTwo())    }
}


// Renders view to image
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
