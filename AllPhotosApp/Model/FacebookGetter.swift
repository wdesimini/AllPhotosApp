//
//  FacebookGetter.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import Foundation
import FBSDKCoreKit


struct FacebookGetter: SocialMediaGetter {
    static func fetchPhotos(completion: @escaping ([Photo]?) -> Void) {
        let graphRequest = GraphRequest(
            graphPath: "/me/photos",
            parameters: [
                "fields": "picture",
                "limit": "1000"
            ]
        )
        
        graphRequest.start(completionHandler:
            { (connection, result, error) -> Void in
                if error != nil {
                    print(error!)
                    completion(nil)
                    return
                }
                
                let fbResult: [String: AnyObject] = result as! [String : AnyObject]
                let userPhotoData = fbResult["data"] as! NSArray
                
                completion(userPhotoData.fetchPhotos(from: .facebook))
        })
    }
}

extension NSArray {

    func fetchPhotos(from mediaSource: SocialMediaService) -> [Photo] {
        var photos = [Photo]()
        
        forEach {
            let photoData = $0 as! NSDictionary
            let photoUrlString = photoData.value(forKey: "picture") as! String
            let imageData = try! Data(
                contentsOf: URL(string: photoUrlString)!
            )
            
            guard let image = UIImage(data: imageData) else { return }
            photos.append(Photo(mediaSource: mediaSource, image: image))
        }
        
        return photos
    }
    
}
