//
//  MapXibView.swift
//  FoodMap
//


import UIKit

//MapXibViewControllerの管理クラス

class MapXibView: UIView {


      func loadNib(){
          let view = Bundle.main.loadNibNamed("MapViewController", owner: self, options: nil)?.first as! UIView
          view.frame = self.bounds
          self.addSubview(view)
      }
}
