//
//  MapViewController.swift
//  ch06-1692163-tabBarController
//
//  Created by 박경훈 on 2021/04/01.
//

import UIKit
import MapKit
import Progress

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let baseURLString = "https://api.openweathermap.org/data/2.5/weather"
        let apiKey = "7e95457c0641c7e7e436c9d424701a95"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("mapviewcontroller.didloadd")
    }
    
    
}
extension MapViewController{
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
}
extension MapViewController{
    override func viewWillAppear(_ animated: Bool) {
        print("mapviewcontroller.viewWillAppear")
        
        let tabBarController = parent as! UITabBarController
        let cityViewController = tabBarController.viewControllers![0] as! CityViewController
        let (city, longitute, latitute) = cityViewController.getCurrentLonLat()
        
        getWeatherData(cityName: city)
        updateMap(title: city, longitute: longitute, latitute: latitute)
        
    }
}

extension MapViewController{
    func updateMap(title: String, longitute : Double?, latitute: Double?){
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        var center = mapView.centerCoordinate
        if let lon = longitute, let lat = latitute{
            center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController {
    func getWeatherData(cityName city: String){
        
        Prog.start(in:self,.activityIndicator)
        var urlStr = baseURLString+"?"+"q="+city+"&"+"appid="+apiKey
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let session = URLSession(configuration: .default)
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        
        let dataTask = session.dataTask(with: request){
            (data, response, error) in
            guard let jsonData = data else{ print(error!); return }
            if let jsonStr = String(data:jsonData, encoding: .utf8){
                print(jsonStr)
            }

            let (temperature, longitute, latitute) = self.extractWeatherData(jsonData: jsonData)
            var title = city
            if let temperature = temperature{
                title += String.init(format: ": %.2f℃", temperature)
            }
            DispatchQueue.main.async {
                self.updateMap(title: title, longitute: longitute, latitute: latitute)
                Prog.dismiss(in:self)
            }
        }
        dataTask.resume()
    }
}

extension MapViewController{
    func extractWeatherData(jsonData: Data) -> (Double?,Double?,Double?){
        let json = try! JSONSerialization.jsonObject(with:jsonData,options:[]) as! [String: Any]
        if let code = json["cod"]{
            if code is String, code as! String == "404"{
            return (nil,nil,nil)
            }
        }
        let lattitute = (json["coord"] as! [String: Double])["lat"]
        let longtitute = (json["coord"] as! [String: Double])["lon"]
        
        guard let temperature = (json["main"] as! [String:Double])["temp"] else{
            return (nil, longtitute,lattitute)
        }
        return (temperature-273,longtitute,lattitute)
    }
}
