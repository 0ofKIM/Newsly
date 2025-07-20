//
//  ViewController.swift
//  Newsly
//
//  Created by 0ofKim on 7/20/25.
//

import Foundation

struct NewsItem: Hashable {
    let id = UUID()
    let title: String
    let content: String
    let imageURL: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        return lhs.id == rhs.id
    }
} 
