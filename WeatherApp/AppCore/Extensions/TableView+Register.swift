//
//  TableView+Register.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 09/11/2022.
//

import UIKit

extension UITableView {
    func registerNib(identifier: String) {
         let tableNib = UINib(nibName: identifier, bundle: nil)
         self.register(tableNib, forCellReuseIdentifier: identifier )
     }
}


