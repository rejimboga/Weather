//
//  ViewController.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import UIKit

class WeatherViewController: UIViewController, ViewControllerBinderProtocol, UITableViewDataSource, RoutingDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherViewModel: WeatherViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherViewModel = WeatherViewModel()
        
        configureView()
        bind()
    }
    
    private func configureView() {
        let tableViewCell = UINib(nibName: "CustomTableViewCell",
                                          bundle: nil)
        self.tableView.register(tableViewCell,
                                forCellReuseIdentifier: "cell")
        self.view.backgroundColor = UIColor(rgb: 0x4A90E2)
    }
    
    func didTap() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let searchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        self.navigationController?.pushViewController(searchViewController, animated: false)
    }
    
    func bind() {
        weatherViewModel?.weatherList.bind({ [weak self] weatherList in
            self?.fillHeaderWithData(weatherList: weatherList ?? [])
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    private func fillHeaderWithData(weatherList: [List]) {
        let tableViewHeader = HeaderTableView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width:                                                                              self.view.frame.width, height: 334)))
        tableView.tableHeaderView = tableViewHeader
        tableViewHeader.delegate = self
        tableViewHeader.headerViewModel.weatherList = weatherList
        DispatchQueue.main.async {
            tableViewHeader.collectionView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherViewModel?.resultArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
        cell.configureSelectedCell()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configureTableViewCell(model: weatherViewModel?.resultArray?[indexPath.row] ?? ViewPresentedModel())
        return cell
    }
    
    
}
