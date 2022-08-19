//
//  CustomCollectionViewCell.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.textColor = UIColor(rgb: 0xFFFFFF)
        }
    }
    @IBOutlet weak var weatherStateImage: UIImageView! {
        didSet {
            weatherStateImage.image = #imageLiteral(resourceName: "ic_white_day_bright")
        }
    }
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = UIColor(rgb: 0xFFFFFF)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureCollectionView(list: List) {
        timeLabel.text = "\(list.dtTxt?.toTime() ?? "")"
        temperatureLabel.text = "\(list.main?.tempMax?.toInt() ?? 0)°"
    }

}
