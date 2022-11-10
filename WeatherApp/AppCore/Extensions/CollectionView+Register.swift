//
//  CollectionView+Register.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import UIKit

extension UICollectionView {
    func registerNib(identifier: String) {
        let collectionNib = UINib(nibName: identifier, bundle: nil)
        self.register(collectionNib, forCellWithReuseIdentifier: identifier )
    }
}
