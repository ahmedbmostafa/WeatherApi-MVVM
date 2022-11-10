//
//  WeatherVC+TableEx.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import UIKit

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewHeightConstraint.constant = CGFloat((matchingItems.count * 25))
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        let mapitem = matchingItems[indexPath.row]
        cell.titleLbl?.text = mapitem.placemark.title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMapItem = matchingItems[indexPath.row]
        searchingTxtF.text = selectedMapItem.placemark.title ?? ""
        let countery = selectedMapItem.name ?? "Egypt"
        self.viewModel.didLoad(countery: countery)
        animateTableView(shouldShow: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if searchingTxtF.text == "" {
            animateTableView(shouldShow: false)
        }
    }
    
}
