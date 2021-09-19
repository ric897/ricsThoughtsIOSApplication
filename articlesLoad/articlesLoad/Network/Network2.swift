//
//  Network2.swift
//  articlesLoad
//
//  Created by Richard Buehling on 9/5/21.
//

import SwiftUI






class networkTwo: ObservableObject {
    @Published var quotes: [Quotes] = []
    
    func getQuotes() {
        guard let url = URL(string: "https://zenquotes.io/api/today/") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedQuotes = try JSONDecoder().decode([Quotes].self, from: data)
                        self.quotes = decodedQuotes
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
