//
//  WebViewController.swift
//  Unit1_Lecture_Demo
//
//  Created by Rolan Marat on 9/24/22.
//

import Foundation
import WebKit
import UIKit

class WebViewController: UIViewController, WKNavigationDelegate {
    private var webView: WKWebView?
    
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://apply.codepath.com/cohorts/university-ios-fall-2022/versions/student/") {
            webView?.load(URLRequest(url: url))
            webView?.allowsBackForwardNavigationGestures = true
        }
    }
}
