//
//  WeatherVC+CollectionViewEx.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import UIKit

extension WeatherVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as? ForecastCollectionViewCell else {return UICollectionViewCell()}
        
        let cellVM = viewModel.getForecastCellViewModel(index: indexPath.row)
        cell.populateWithViewModel(cellViewModel: cellVM)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
}
