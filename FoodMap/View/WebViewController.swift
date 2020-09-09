//
//  WebViewController.swift
//  FoodMap
//


import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    
    var url:String = ""

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        let myURL = URL(string:url)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
    }
    
    //webview内で電話メール起動したい
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            guard let url = navigationAction.request.url else {
                return
            }

            if navigationAction.navigationType == .linkActivated {
                if url.scheme == "mailto" || url.scheme == "tel" {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    decisionHandler(.cancel)
                    return
                }
            }

            decisionHandler(.allow)
        }
    


  
}
