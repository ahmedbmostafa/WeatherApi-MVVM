//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateWithViewModel(cellViewModel: ForecastCellViewModel) {
        tempLbl.text = cellViewModel.temp ?? ""
        dayLbl.text = cellViewModel.day ?? ""
        self.updateIcon(icon: cellViewModel.icon, code: cellViewModel.code ?? "", text: cellViewModel.text ?? "")
    }
    
    func updateIcon(icon: [String], code: String, text: String){
        let fm = FileManager.default
        for _ in icon {
            let image = fm.getImageInBundle(bundlePath: "\(text).bundle/\(code)")
            self.iconImage.image = image
        }
    }
    
}
