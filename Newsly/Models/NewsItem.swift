//
//  ViewController.swift
//  Newsly
//
//  Created by 0ofKim on 7/20/25.
//

import Foundation
// TODO: API 확인 후 데이터에 맞게 수정
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
