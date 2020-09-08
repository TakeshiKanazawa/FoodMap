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

    override func viewDidLoad() {
        super.viewDidLoad()
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
        mapView.setRegion(region, animated:true)


        
        getData()
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
                        //取得したJSOnからお店の名前を取得
                        let name = json["results"]["shop"][i]["name"].string
                        let lat = json["results"]["shop"][i]["lat"].double
                        let lng = json["results"]["shop"][i]["lng"].double
                        let pic = json["results"]["shop"][i]["logo_image"].string
                        let genre = json["results"]["shop"][i]["genre"]["name"].string

                        //let marker = CustomGMSMarker()
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
                        //pinのタイトル
                        annotation.title = name
                        annotation.subtitle = genre

                        self.mapView.addAnnotation(annotation)

                    }

                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }

}
