//
//  ViewController.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import UIKit
import CoreLocation
import MapKit

class WeatherVC: UIViewController {
    
    
    @IBOutlet weak var mainIcon: UIImageView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchingTxtF: UITextField!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempKindLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var dropLetLbl: UILabel!
    @IBOutlet weak var todayIcon: UIImageView!
    @IBOutlet weak var todayTemp: UILabel!
    @IBOutlet weak var tomorrowIcon: UIImageView!
    @IBOutlet weak var tomorrowTempLbl: UILabel!
    @IBOutlet weak var thirdDayIcon: UIImageView!
    @IBOutlet weak var thirdDayLbl: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var containerSearchView: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dragginView: UIView!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var dayDescriptionLbl: UILabel!
    
    
    var viewModel: WeatherViewModelProtocol!
    var activityIndicator: ActivityIndicatorStates!
    let locationManager = CLLocationManager()
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var current: CurrentWeatherModel?
    var shouldUpdate = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        getCurrentUserLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchingTxtF.delegate = self
        self.activityIndicator = ActivityIndicator()
        setUpTableView()
        setUpCollectionView()
        draggingViewAction()
        bindViewModelOutput()
    }
    
    
    func setUpTableView(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.registerNib(identifier: "SearchTableViewCell")
    }
    
    func setUpCollectionView(){
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        forecastCollectionView.registerNib(identifier: "ForecastCollectionViewCell")
    }
    
    func draggingViewAction() {
        let upRecognizer = UISwipeGestureRecognizer(target: self, action:#selector(swipeMade(_:)))
        upRecognizer.direction = .up
        dragginView.addGestureRecognizer(upRecognizer)
    }
    
    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            self.animateTableView(shouldShow: false)
        }
    }
    
    func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else {return}
            switch output {
                
            case .updateForecasrData(current: let current):
                self.current = current
                self.forecastCollectionView.reloadData()
                
            case .mainCity(city: let city):
                self.cityLbl.text = city
                
            case .mainIcon(icon: let icon, code: let code, text: let text):
                self.updateIcon(icon: icon, code: code, text: text)
                
            case .mainTime(time: let time):
                self.timeLbl.text = time
                
            case .mainDate(date: let date):
                self.dateLbl.text = date
                
            case .mainTemp(temp: let temp):
                self.tempLbl.text = temp
                
            case .mainWind(wind: let wind):
                self.windLbl.text = wind
                
            case .mainHumidity(humidity: let humidity):
                self.dropLetLbl.text = humidity
                
            case .dayDescription(text: let text):
                self.dayDescriptionLbl.text = text
                
            case .showActivityIndicator(let show):
                show ? self.activityIndicator.startAnimating(viewController: self) : self.activityIndicator.stopAnimating()
                
            case .showError(let error):
                UIAlertController.showAlert(withMessage: error.localizedDescription)
                
            }
            
        }
    }
    
    func updateIcon(icon: [String], code: String, text: String){
        let fm = FileManager.default
        for _ in icon {
            let image = fm.getImageInBundle(bundlePath: "\(text).bundle/\(code)")
            self.mainIcon.image = image
        }
    }
    
    func performSearch(){
        
        matchingItems = []
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchingTxtF.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if error != nil {
                UIAlertController.showAlert(withMessage: "Valid location! please search again.")
            }else if response?.mapItems.count == 0 {
                UIAlertController.showAlert(withMessage: "Valid location! please search again.")
            } else {
                for mapitem in response!.mapItems {
                    self.matchingItems.append(mapitem as MKMapItem)
                    self.animateTableView(shouldShow: true)
                    
                }
            }
        }
        
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        searchView.isHidden = false
        backBtn.isHidden = false
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        searchView.isHidden = true
        containerSearchView.isHidden = true
        backBtn.isHidden = true
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        searchingTxtF.text = ""
    }
    
}

