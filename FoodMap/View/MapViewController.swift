//
//  MapViewController.swift
//  FoodMap

//Mapのビュー表示に関連するクラス

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
     //locationManagerのインスタンス
    var locationManager:CLLocationManager!

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


        

    }

    func requestLoacion() {

        //位置情報サービスの確認
        CLLocationManager.locationServicesEnabled()
        // セキュリティ認証のステータス
        let status = CLLocationManager.authorizationStatus()
        
        if(status == CLAuthorizationStatus.notDetermined) {
            // 許可をリクエスト
            locationManager.requestWhenInUseAuthorization()
        }
        // ユーザにアプリ使用中のみ位置情報取得の許可を求めるダイアログを表示
       // locationManager.requestWhenInUseAuthorization()
        // 常に取得したい場合はこちら↓
        // locationManager.requestAlwaysAuthorization()
        // CLLocationManagerのインスタンス生成

    }


}
