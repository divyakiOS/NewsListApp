//
//  NewsModel.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import Foundation
import UIKit

struct NewsModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case newsList = "payload"
        case success
        case message
    }
    
    let newsList : [News]?
    let success : Bool?
    let message : String?
    
    struct News: Codable {
        
        enum CodingKeys: String, CodingKey {
            
            case title
            case description
            case date
            case image
        }
        let title : String?
        let description : String?
        let date : String?
        let image : String?
    }
}
