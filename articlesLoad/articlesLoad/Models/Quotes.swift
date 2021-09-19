//
//  Quotes.swift
//  articlesLoad
//
//  Created by Richard Buehling on 9/5/21.
//

import Foundation






struct Quotes: Decodable, Identifiable {
    let id = UUID()
    let q: String
    let a: String
    
}
   
