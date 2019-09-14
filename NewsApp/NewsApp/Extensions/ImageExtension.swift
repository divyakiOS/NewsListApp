//
//  ImageExtension.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import UIKit

extension UIImageView {
    
    
    
    func loadImage(_ url: String?, completion: @escaping ((Bool) -> ())) {
        
        guard let urlString = url, let imageUrl = URL(string: urlString) else {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            
            guard let weakSelf = self, error == nil, let imageData = data else {
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                weakSelf.image = UIImage(data: imageData)
                completion(true)
            }
            }.resume()
    }
}
