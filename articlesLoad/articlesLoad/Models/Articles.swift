//
//  Articles.swift
//  articlesLoad
//
//  Created by Richard Buehling on 8/23/21.
//

import Foundation






struct Articles: Identifiable, Decodable {
    
    let id = UUID()
    var _id: String
    var title: String
    var category: String
    var slug: String
    var image: String
}





