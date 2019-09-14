//
//  NewsCellViewModel.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import Foundation
class NewsCellViewModel: NSObject {
    
    var news: NewsModel.News? = nil
    
    var newsImageURLString: String? {
        
        return "\(news?.image ?? "")"
    }
    
    var titleString: String? {
        return "\(news?.title ?? "")"
    }
    
    var descriptionString: String? {
        return "\(news?.description ?? "")"
    }
    
    var dateString: String? {
        return "Updated on \(news?.date ?? "")"
    }
    
}
