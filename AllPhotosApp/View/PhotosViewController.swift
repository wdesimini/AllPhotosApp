//
//  ViewController.swift
//  AllPhotosApp
//
//  Created by Wilson Desimini on 6/30/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class PhotosViewController: UIViewController {
    private var user = User()
    private lazy var userViewModel = UserViewModel(user: user)
    
    private var images: [UIImage] {
        return user.photos.map { $0.image }
    }
    
    private lazy var activityIndicator: LoadingView = {
        let loadingView = LoadingView()
        view.addSubview(loadingView)
        loadingView.backgroundColor = view.backgroundColor
        loadingView.pin(to: view)
        return loadingView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = Size.sectionInsets
        layout.itemSize = collectionViewItemSize
        
        let collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialViews()
    }
    
    private func configureInitialViews() {
        activityIndicator.startAnimating()
        userViewModel.delegate = self
        
        if AccessToken.current != nil {
            userViewModel.fetchFacebookPhotos { success in
                self.activityIndicator.stopAnimating()
            }
        } else {
            configureButton()
        }
    }
    
    private func configureButton() {
        let button = FBLoginButton()
        button.center = view.center
        button.permissions = ["public_profile", "email", "user_photos"]
        view.addSubview(button)
    }
    
}

extension PhotosViewController: UserViewModelDelegate {
    func updated(user: User) {
        self.user = user
        collectionView.reloadData()
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MyCell",
            for: indexPath)
            as! ImageCollectionViewCell
        
        myCell.setCell(with: images[indexPath.item])
        return myCell
    }
}

extension PhotosViewController {
    private struct Size {
        static let sectionInsets = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        static let collectionViewItemScale: CGFloat = 60
    }
    
    private var collectionViewItemSize: CGSize {
        return CGSize(
            width: Size.collectionViewItemScale,
            height: Size.collectionViewItemScale
        )
    }
}
