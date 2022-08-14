//
//  Router.swift
//  Weather
//
//  Created by Macbook Air on 14.08.2022.
//

import Foundation

class Router {
    
    unowned var vc: WeatherViewController
    
    init(vc: WeatherViewController) {
        self.vc = vc
    }
    
    func navigateToSupportContacts() {
        vc.performSegue(withIdentifier: Segue.navigateToSearch.rawValue, sender: nil)
    }
    
    //MARK: - Segue
    enum Segue: String {
        case navigateToSearch
    }
}
