//
//  SignInModel.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import Foundation
import UIKit

struct SignInModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case message, success
        case response = "payload"
    }
    
    let message : String?
    let success : Bool?
    let response : Response?
    
    struct Response: Codable {
        
        enum CodingKeys: String, CodingKey {
            
            case referenceNo
        }
        let referenceNo : Int?
        
    }
}
