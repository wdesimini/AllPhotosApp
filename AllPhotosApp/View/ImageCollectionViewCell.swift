//
//  ImageCollectionViewCell.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit


class ImageCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.frame = contentView.frame
        return imageView
    }()
    
    func setCell(with image: UIImage) {
        backgroundColor = .black
        imageView.image = image
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        super.prepareForReuse()
    }
}
