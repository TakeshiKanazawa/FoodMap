//
//  HotPepperAPIClient.swift
//  FoodMap
//


import Foundation
import Alamofire
import CoreLocation


//HTTPリクエストを行うための拡張可能なProtocol
protocol APIClient {
  //  var url: String { get }
    func getRequest(_ parameters: [String : String]) -> DataRequest
}

// HotPepper APIを呼び出すクラス
class HotPepperAPIClient: APIClient {
    // HotPepper APIに向けてHTTPリクエストを実行
    func getRequest(_ parameters: [String : String]) -> DataRequest
    {
        //locationManagerのインスタンス
    var locationManager: CLLocationManager!
     let   lat = locationManager.location?.coordinate.latitude as! Double
     let lng = locationManager.location?.coordinate.longitude as! Double
        return AF.request(URL(string:"http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=c670a187d5210c60&lat=\(lat)&lng=\(lng)&range=5&order=4&format=json&count=20")!,
         method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
    }
    
}
