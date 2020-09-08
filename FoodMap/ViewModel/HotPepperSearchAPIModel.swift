////
////  HotPepperSearchAPIModel.swift
////  FoodMap
////
//
//
//import Foundation
//import RxSwift
//import SwiftyJSON
//
//class HotPepperSearchAPIModel {
//    let client = HotPepperAPIClient()
// 
//   // wikipedia 検索実体   Wikipedia APIでの検索結果をObservableで扱えるようにするためのメソッド
//    private func searchHotPepper(_ parameters:[String:String]) -> Observable<[APIResult]> {
//        // [APIResult]型のObservableオブジェクトを生成
//        return Observable<[APIResult]>.create { (observer) -> Disposable in
//            // Wikipedia APIへHTTPリクエストを送信
//            let request = self.client.getRequest(parameters).responseJSON{ response in    // -------（1）
//                // 結果にエラーがあればonErrorに渡して処理を終える
//                if let error = response.error {    // -------（2）
//                    observer.onError(error)
//                }
//                // 結果をパースして[Result]に変換
//                let results = self.parseJson(response.value as? [String: Any] ?? [:])    // -------（3）
//                // onNextに渡す
//                observer.onNext(results)
//                // 完了
//                observer.onCompleted()
//            }
//            return Disposables.create { request.cancel() }
//        }
//    }
//    
//
//    // JSON解析メソッド
//    private func parseJson(_ json: Any) -> [APIResult] {
//        guard let items = json as? [String: Any] else { return [] }
//        var results = [APIResult]()
//        // JSONの階層を追って検索結果を配列で返す
//        if let queryItems = items["query"] as? [String:Any] {
//            if let searchItems  = queryItems["search"] as? [[String: Any]] {
//                searchItems.forEach{
//                    guard let title = $0["shopName"] as? String,
//                        let pageid = $0["pageid"] as? Int else {
//                            return
//                    }
//                    results.append(APIResult(title: title, pageid: pageid))
//                     let shopName:String
//                        //緯度
//                        let lat:Double
//                        //軽度
//                        let lng:Double
//                    //    店舗ジャンル
//                        let shopGenre:String
//                    //    お店写真(PC版、Lサイズ)
//                        let shopPhoto:String
//                    //    キャッチコピー
//                        let shop_Catch:String
//                    //    営業時間
//                        let shop_open_time:String
//                    //    平均予算
//                        let ave_Budget:String
//                    //    休業日
//                        let shop_Close_Time:String
//                    //    店舗URL
//                        let shop_URL:String
//                }
//            }
//        }
//        return results
//    }
//}
//
