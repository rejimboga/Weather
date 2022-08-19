//
//  CustomTableViewCell.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStateImage: UIImageView! {
        didSet {
            weatherStateImage.image = #imageLiteral(resourceName: "ic_white_day_shower").withTintColor(.black)
        }
    }
    
    func configureSelectedCell() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(rgb: 0xFFFFFF)
        dateLabel.textColor = UIColor(rgb: 0x5A9FF0)
        temperatureLabel.textColor = UIColor(rgb: 0x5A9FF0)
        weatherStateImage.image = #imageLiteral(resourceName: "ic_white_day_shower").withTintColor(UIColor(rgb: 0x5A9FF0))
    }
    
    func configureTableViewCell(model: ViewPresentedModel) {
        dateLabel.text = "\(model.date.toDay())"
        temperatureLabel.text = "\(model.minTemp.toInt() ?? 0)° / \(model.maxTemp.toInt() ?? 0)°"
    }
}
