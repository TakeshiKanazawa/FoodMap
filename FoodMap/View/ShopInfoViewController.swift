//
//  ShopInfoViewController.swift
//  FoodMap
//
//  Created by 金澤武士 on 2020/09/03.
//  Copyright © 2020 tk. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage
import CoreLocation

//店舗情報の表示に関連するクラス
class ShopInfoViewController: UIViewController {
      var id = ""
    var url = ""
    var lat:Double  = 0.00
    var lng:Double  = 0.00
    var lat2:Double  = 0.00
    var lng2:Double  = 0.00
    var shop:String = ""
    var address:String = ""
    
    
    @IBAction func view_HPWeb(_ sender: Any) {
        //取得したURLからwebを開く
        let nextViewController =  WebViewController()
        nextViewController.url = url
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    var locationManager = CLLocationManager()
     //位置情報使用許可のリクエストを表示するメソッドの呼び出し

  
 
    @IBAction func open_Mapapp(_ sender: Any) {

      let addressEncoded =  urlEncode(string:address)
        let  urlString = "http://maps.apple.com/?&daddr=\(addressEncoded),&dirflg=w"
        print(urlString)
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    //Xibの部品を全てoutletで繋ぐ
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopGenre: UILabel!
    @IBOutlet weak var shopPhoto: UIImageView!
    @IBOutlet weak var shop_open_time: UILabel!
    @IBOutlet weak var ave_Budget: UILabel!
    @IBOutlet weak var shop_Close_Time: UILabel!
    @IBOutlet weak var shop_Map: UIButton!
    @IBOutlet weak var shop_Catch: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        shop = self.shopName.text ?? "店名エラー"
         lat2 = locationManager.location?.coordinate.latitude as! Double
          lng2 = locationManager.location?.coordinate.longitude as! Double
        
    }
        func getData() {
            let text = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=c670a187d5210c60&id=\(id)&format=json"
            let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in

                //JSON解析
                switch response.result {
                case .success:

                
                        let json: JSON = JSON(response.data as Any)
                        //必要な情報だけ取得(この場合shopnameとshopGenreと店舗ID。IDを次画面へ渡す)
                        self.shopName.text = json["results"]["shop"][0]["name"].string ?? "店名が取得できませんでした"
                        self.shopGenre.text = json["results"]["shop"][0]["genre"]["name"].string  ?? "ジャンルが取得できませんでした"
                         let imageURLString = json["results"]["shop"][0]["photo"]["pc"]["l"].string  ?? "写真が取得できませんでした"
                        let urlimage = URL(string: imageURLString)
                        self.shopPhoto.sd_setImage(with: urlimage)
                        self.shop_Catch.text = json["results"]["shop"][0]["catch"].string  ?? "キャッチコピーが取得できませんでした"
                        self.shop_open_time.text = json["results"]["shop"][0]["open"].string  ?? "営業時間が取得できませんでした"
                        self.ave_Budget.text = json["results"]["shop"][0]["budget"]["average"].string  ?? "平均予算が主取得できませんでした"
                        self.shop_Close_Time.text = json["results"]["shop"][0]["close"].string  ?? "休業日が取得できませんでした"
                        self.url = json["results"]["shop"][0]["urls"]["pc"].string  ?? "店舗URLが取得できませんでした"
                        self.lat = json["results"]["shop"][0]["lat"].double  ?? 0.0
                       self.lng = json["results"]["shop"][0]["lng"].double  ?? 0.0
                        self.shop =  json["results"]["shop"][0]["name"].string ?? ""
                        self.address =  json["results"]["shop"][0]["address"].string ?? ""
                    
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    func urlEncode(string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }

}
