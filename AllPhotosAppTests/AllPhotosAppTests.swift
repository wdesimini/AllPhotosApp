//
//  AllPhotosAppTests.swift
//  AllPhotosAppTests
//
//  Created by Wilson Desimini on 7/1/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import XCTest
@testable import AllPhotosApp

class AllPhotosAppTests: XCTestCase {
    
    func testPhotosVsRealmPhotos() {
        let promise = expectation(description: "Closure Completed")
        var photosFromFacebook: [Photo]?
        
        FacebookGetter.fetchPhotos { photos in
            guard photos != nil else {
                XCTFail("no photos found from facebook")
                return
            }
            
            photosFromFacebook = photos
            promise.fulfill()
        }
        
        let userViewModel = UserViewModel(user: User())
        let realmPhotos = userViewModel.getRealmPhotos()
        var photosFromRealm: [Photo] = []
        
        for realmPhoto in realmPhotos {
            photosFromRealm.append(realmPhoto.photo)
        }
        
        wait(for: [promise], timeout: 10)
        XCTAssertEqual(photosFromFacebook!, photosFromRealm)
    }
}
