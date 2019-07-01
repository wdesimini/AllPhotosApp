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
import RealmSwift


protocol UserViewModelDelegate: class {
    func updated(user: User)
}

class UserViewModel {
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    weak var delegate: UserViewModelDelegate?
    
    private let realm = try! Realm()
    private lazy var realmPhotos = realm.objects(RealmPhoto.self)
    
    public func fetchUserPhotos(completion: @escaping (Bool) -> Void) {
        if realmPhotos.count != 0 {
            updateUserPhotos(to: realmPhotos.map { $0.photo })
            completion(true)
        } else {
            fetchFacebookPhotos { success in
                completion(success)
            }
        }
    }
    
    private func fetchFacebookPhotos(completion: @escaping (Bool) -> Void) {
        FacebookGetter.fetchPhotos { photos in
            guard photos != nil else {
                completion(false)
                return
            }
            
            self.writePhotosToRealm(photos!)
            completion(true)
        }
    }
    
    private func writePhotosToRealm(_ photos: [Photo]) {
        try! realm.write {
            realm.add(
                photos.map {
                    let realmPhoto = RealmPhoto()
                    if let pngData = $0.image.pngData() {
                        realmPhoto.imageData = NSData(data: pngData)
                    } else {
                        realmPhoto.imageData = NSData(data: $0.image.jpegData(compressionQuality: 0.9)!)
                    }
                    realmPhoto.mediaSourceString = $0.mediaSource?.rawValue
                    return realmPhoto
                }
            )
            
            updateUserPhotos(to: realmPhotos.map { $0.photo })
        }
    }
    
    private func updateUserPhotos(to photos: [Photo]) {
        user.photos = photos
        delegate?.updated(user: user)
    }
    
    #warning("for UNITTESTING: comment this out if not testing")
    func getRealmPhotos() -> Results<RealmPhoto> {
        return realmPhotos
    }
}
