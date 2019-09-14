//
//  NewsListTableViewCell.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//

import UIKit
import QuartzCore

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgVphoto: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet var lblDescription: UILabel!
    var cellViewModel: NewsCellViewModel? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewMain.layer.shadowColor = UIColor.lightGray.cgColor
        viewMain.layer.shadowOpacity = 1
        viewMain.layer.shadowOffset = CGSize.zero
        viewMain.layer.shadowRadius = 6
        // Initialization code
    }

    func configureCell() {
        
        lblTitle.text = cellViewModel?.titleString
        lblTime.text = cellViewModel?.dateString
        lblDescription.text = cellViewModel?.descriptionString
        // Load images with activity spinner
        activity.startAnimating()
        imgVphoto.image = UIImage()
        imgVphoto.loadImage(cellViewModel?.newsImageURLString) { [weak self] (loaded) in
            
            guard let weakSelf = self else {  return }
            
            if loaded {
                weakSelf.activity.stopAnimating()
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
