//
//  RealmPhoto.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPhoto: Object {
    @objc dynamic var imageData: NSData!
    @objc dynamic var mediaSourceString: String?
}

extension RealmPhoto {
    var photo: Photo {
        return Photo(
            mediaSourceString: mediaSourceString,
            imageData: imageData
        )
    }
}
