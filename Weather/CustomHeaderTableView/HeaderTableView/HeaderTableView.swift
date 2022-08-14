//
//  HeaderTableView.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//


import UIKit

class HeaderTableView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Vars
    var headerViewModel = HeaderViewModel()
    var delegate: RoutingDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var locationButton: UIButton! {
        didSet {
            locationButton.setImage(UIImage(named: "ic_place"), for: .normal)
        }
    }
    
    @IBOutlet weak var currentLocationButton: UIButton! {
        didSet {
            currentLocationButton.setImage(UIImage(named: "ic_my_location"), for: .normal)
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weatherState: UIImageView! {
        didSet {
            weatherState.image = #imageLiteral(resourceName: "ic_white_day_cloudy")
        }
    }
    
    
    @IBOutlet weak var temperatureImage: UIImageView! {
        didSet {
            temperatureImage.image = #imageLiteral(resourceName: "ic_temp")
        }
    }
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var humidityImage: UIImageView! {
        didSet {
            humidityImage.image = #imageLiteral(resourceName: "ic_humidity")
        }
    }
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var windSpeedImage: UIImageView! {
        didSet {
            windSpeedImage.image = #imageLiteral(resourceName: "ic_wind")
        }
    }
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windSpeedDirection: UIImageView! {
        didSet {
            windSpeedDirection.image = #imageLiteral(resourceName: "icon_wind_se.pdf")
        }
    }
    
    @IBAction func seacrhLocation(_ sender: Any) {
        print("tapped")
        delegate?.didTap()
    }
    
    //MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    //MARK: - Functions
    private func configureView() {
        let nibName = "HeaderTableView"
        guard let view = self.loadViewFromNib(nibName: nibName) else { return }
        
        view.backgroundColor = UIColor(rgb: 0x4A90E2)
        view.frame = self.bounds
        view.fixInView(self)
        self.addSubview(view)
        headerViewModel.getCurrentWeather()
        initCollectionView()
        bind()
    }
    
    private func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(rgb: 0x5A9FF0)
    }
    
    private func setView(with weather: CurrentWeatherForecast) {
        locationLabel.text = "Kyiv"
        dateLabel.text = "\(Date().currentDay())"
        temperatureLabel.text = "\(weather.main?.temp_min?.toInt() ?? 0)° / \(weather.main?.temp_max?.toInt() ?? 0)°"
        humidityLabel.text = "\(weather.main?.humidity ?? 0)%"
        windSpeedLabel.text = "\(weather.wind?.speed ?? 0.0)m/sec"

    }
    
    func bind() {
        headerViewModel.currentWeather.bind { [weak self] currentWeatherList in
            guard let weather = currentWeatherList else { return }
            self?.setView(with: weather)
        }
    }

    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerViewModel.numberOfItems() 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell()}
        guard let weatherList = headerViewModel.weatherList else { return UICollectionViewCell()}
        cell.configureCollectionView(list: weatherList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
    
}
