//
//  PhotoCollectionViewCell.swift
//  PhotoLog
//
//  Created by Lio on 2022/12/13.
//

import UIKit
import expanding_collection

class PhotoCollectionViewCell: BasePageCollectionCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var customTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customTitle.layer.shadowRadius = 2
        customTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        customTitle.layer.shadowOpacity = 0.2
    }
    
}
