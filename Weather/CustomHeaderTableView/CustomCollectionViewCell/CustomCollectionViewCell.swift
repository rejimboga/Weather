//
//  CustomCollectionViewCell.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherStateImage: UIImageView! {
        didSet {
            weatherStateImage.image = #imageLiteral(resourceName: "ic_white_day_bright")
        }
    }
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureCollectionView(list: List) {
        timeLabel.text = "\(list.dt_txt?.toTime() ?? "")"
        temperatureLabel.text = "\(list.main?.temp_max?.toInt() ?? 0)°"
    }

}
