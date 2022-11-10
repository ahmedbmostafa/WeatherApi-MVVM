//
//  WeatherVC+TextFieldEx.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import UIKit

extension WeatherVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchingTxtF {
            performSearch()
            view.endEditing(true)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        matchingItems = []
        searchTableView.reloadData()
        return true
    }
    
    func animateTableView(shouldShow: Bool) {
        if shouldShow {
            
            UIView.animate(withDuration: 0.2) {
                self.containerSearchView.isHidden = false
                self.searchTableView.reloadData()
            }
            
        }else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.searchView.isHidden = true
                self.containerSearchView.isHidden = true
                self.searchTableView.reloadData()
            })
            
        }
    }
    
}
