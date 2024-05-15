//
//  ImageCVC.swift
//  LazyDemo
//
//  Created by Rakesh Sharma on 09/05/24.
//

import UIKit

class ImageCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgThumb: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var identifire : String{
        return String(describing: self)
    }
    
    static var nib : UINib{
        return UINib(nibName: identifire, bundle: Bundle.main)
    }
}
