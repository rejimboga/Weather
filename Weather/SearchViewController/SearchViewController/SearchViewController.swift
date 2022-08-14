//
//  SearchViewController.swift
//  Weather
//
//  Created by Macbook Air on 14.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var stack: UIStackView! {
        didSet {
            stack.backgroundColor = UIColor(rgb: 0x4A90E2)
        }
    }
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Vars
    let searchViewModel = SearchViewModel()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb: 0x4A90E2)
        
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
    }
    
    //MARK: - Functions
    @IBAction func backButtonIsTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let weatherViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else { return }
        navigationController?.pushViewController(weatherViewController, animated: false)
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text?.count != 0 {
            searchViewModel.searchResult.removeAll()
            for city in searchViewModel.cities {
                let range = city.city.lowercased().range(of: textField.text ?? "", options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    searchViewModel.searchResult.append(city)
                }
            }
        }
        tableView.reloadData()
        return true
    }
                                  
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = searchViewModel.searchResult[indexPath.row].city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // passing data
    }
    
    
}
