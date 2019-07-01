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
