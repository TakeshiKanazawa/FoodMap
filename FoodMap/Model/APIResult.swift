//
//  APIResult.swift
//  FoodMap
//

//JSONの検索結果を格納する構造体

import Foundation

struct APIResult {
//    店名
    let shopName:String
    //緯度
    let lat:Double
    //軽度
    let lng:Double
//    店舗ジャンル
    let shopGenre:String
//    お店写真(PC版、Lサイズ)
    let shopPhoto:String
//    キャッチコピー
    let shop_Catch:String
//    営業時間
    let shop_open_time:String
//    平均予算
    let ave_Budget:String
//    休業日
    let shop_Close_Time:String
//    店舗URL
    let shop_URL:String
    
    
}
