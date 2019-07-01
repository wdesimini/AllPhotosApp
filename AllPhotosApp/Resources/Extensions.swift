//
//  Extensions.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit


// pin one view to another
extension UIView {
    func pin(to parentView: UIView) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: parentView.heightAnchor),
            widthAnchor.constraint(equalTo: parentView.widthAnchor),
            centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            ])
    }
}

extension UIImage {
    
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = self.pngData()! as NSData
        let data2: NSData = image.pngData()! as NSData
        return data1.isEqual(data2)
    }
    
}
