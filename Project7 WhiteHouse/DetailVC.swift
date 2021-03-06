//
//  DetailVC.swift
//  Project7 WhiteHouse
//
//  Created by Harsh Verma on 08/08/21.
//

import UIKit
import WebKit
class DetailVC: UIViewController {

    var webView: WKWebView!
    var details: Petition?
    
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = details else {
            return
        }
        let html = """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style> body { font-size: 150%; } </style>
            </head>
            <body>
            \(detailItem.body)
            </body>
            </html>
            """
        
        webView.loadHTMLString(html, baseURL: nil)
        // Do any additional setup after loading the view.
    }
    


}
