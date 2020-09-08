//
//  MapViewController.swift
//  FoodMap

//Mapのビュー表示に関連するクラス

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON
import Alamofire

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    //locationManagerのインスタンス
    var locationManager: CLLocationManager!
    //緯度
    var lat = Double()
    //軽度
    var lng = Double()
    
    var results = [APIResult]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //CLLocationManagerをインスタンス化
        locationManager = CLLocationManager()
        //位置情報使用許可のリクエストを表示するメソッドの呼び出し
        locationManager.requestWhenInUseAuthorization()

        //地図の中心=ユーザの現在地へ移動
        mapView.setCenter(mapView.userLocation.coordinate, animated: false)
        //ユーザが移動=地図の中心も追従
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading

        lat = locationManager.location?.coordinate.latitude as! Double
        lng = locationManager.location?.coordinate.longitude as! Double

        // 縮尺を設定
        let location = CLLocationCoordinate2DMake(lat, lng)
        var region = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        // マップビューに縮尺を設定
        mapView.setRegion(region, animated: true)


        getData()
                print(self.results)
    
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
        if annotation.title == "My Location"{
            return nil
        }
     
          markerAnnotationView.canShowCallout = true
          markerAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
          return markerAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        if control == view.rightCalloutAccessoryView{
            print("次の画面へ！")
        }
    }

    func getData() {
        let text = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=c670a187d5210c60&lat=\(lat)&lng=\(lng)&range=5&order=4&format=json&count=20"
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //リクエストを送るcount=

        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in


            //JSON解析
            switch response.result {
            case .success:

                for i in 0 ... 19 {
                    let json: JSON = JSON(response.data as Any)
                    //必要な情報だけ取得
                    let shopName = json["results"]["shop"][i]["name"].string
                    let latitude = json["results"]["shop"][i]["lat"].double
                    let longitude = json["results"]["shop"][i]["lng"].double
                    let shopGenre = json["results"]["shop"][i]["genre"]["name"].string
                    let shopPhoto = json["results"]["shop"][i]["photo"]["pc"]["l"].string
                    let shop_Catch = json["results"]["shop"][i]["catch"].string
                    let shop_open_time = json["results"]["shop"][i]["open"].string
                    let ave_Budget = json["results"]["shop"][i]["budget"]["average"].string
                    let shop_Close_Time = json["results"]["shop"][i]["close"].string
                    let shop_URL = json["results"]["shop"][i]["urls"]["pc"].string

                    //let marker = CustomGMSMarker()
                    let annotation = MKPointAnnotation()
                
                    annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                    //pinのタイトル
                    annotation.title = shopName
                    annotation.subtitle = shopGenre

                    self.mapView.addAnnotation(annotation)
                    let apiStruct = APIResult(shopName: shopName!, lat: latitude!, lng: longitude!, shopGenre: shopGenre!, shopPhoto: shopPhoto!, shop_Catch: shop_Catch!, shop_open_time: shop_open_time!, ave_Budget: ave_Budget!, shop_Close_Time: shop_Close_Time!, shop_URL: shop_URL!)
                    
                    self.results.append(apiStruct)
                    
                }

                break
            case .failure(let error):
                print(error)
                break
            }
    //        print(self.results)
        }
    }
}

