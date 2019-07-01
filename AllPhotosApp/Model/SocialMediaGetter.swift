//
//  SocialMediaPhotoGetter.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation


protocol SocialMediaGetter {
    static func fetchPhotos(completion: @escaping ([Photo]?) -> Void)
}
