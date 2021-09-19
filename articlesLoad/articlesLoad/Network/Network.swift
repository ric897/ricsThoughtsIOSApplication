//
//  Network.swift
//  articlesLoad
//
//  Created by Richard Buehling on 8/23/21.
//

import SwiftUI






class Network: ObservableObject {
    @Published var articles: [Articles] = []
    
    func getArticles() {
        guard let url = URL(string: "https://richardbuehling.com/articles") else { fatalError("Missing URL") }

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
                        let decodedArticles = try JSONDecoder().decode([Articles].self, from: data)
                        self.articles = decodedArticles.reversed()
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}



