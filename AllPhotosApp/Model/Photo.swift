//
//  Photo.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import UIKit


struct Photo: Equatable {
    var mediaSource: SocialMediaService?
    var image: UIImage!
    
    init(mediaSource: SocialMediaService? = nil, image: UIImage) {
        self.mediaSource = mediaSource
        self.image = image
    }
    
    init(mediaSourceString: String?, imageData: NSData) {
        if mediaSourceString != nil {
            self.mediaSource = SocialMediaService(rawValue: mediaSourceString!)
        }
        
        self.image = UIImage(data: imageData as Data)
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.image.isEqualToImage(image: rhs.image) && lhs.mediaSource == rhs.mediaSource
    }
}
