//
//  UserViewModel.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit


protocol UserViewModelDelegate: class {
    func updated(user: User)
}

class UserViewModel {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    weak var delegate: UserViewModelDelegate?
    
    public func fetchFacebookPhotos(completion: @escaping (Bool) -> Void) {
        FacebookGetter.fetchPhotos { photos in
            guard photos != nil else {
                completion(false)
                return
            }
            
            self.updateUserPhotos(to: photos!)
            completion(true)
        }
    }
    
    private func updateUserPhotos(to photos: [Photo]) {
        user.photos = photos
        delegate?.updated(user: user)
    }
}

