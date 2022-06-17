//
//  ViewController.swift
//  DKOTC
//
//  Created by po feng Lin on 2021/7/8.
//

import UIKit
import WebKit

class MainController: UIViewController {

    var mModel: WebViewModel = WebViewModel()
    var mView : WebView = WebView()
    
    var mWebView: WKWebView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://pofenglin079.github.io/PoFengBill/"
        mModel.setUrlString(mUrl: url)
        showWebView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterActive), name: UIScene.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resignActive), name: UIScene.willDeactivateNotification, object: nil)
    }
    
    private func showWebView(){
        let url = URL(string: mModel.getUrlString())
        
        if let url = url {
            let request = URLRequest(url: url)
            let mFrame = self.view.frame
            
            mView.initView(mFrame: mFrame)
            mWebView = mView.getWebView()
            if let mWebView = mWebView {
                mWebView.navigationDelegate = self
                mWebView.scrollView.bounces = false
                mWebView.scrollView.contentInsetAdjustmentBehavior = .never
                
                mWebView.load(request)
                self.view.addSubview(mWebView)
                self.view.sendSubviewToBack(mWebView)
            }
        }
    }
    
    @objc func enterActive() {
        print ("enterActive")
        playPlay()
    }
    
    @objc func resignActive() {
        print ("resignActive")
        pausePlay()
    }
    
    func playPlay(){
        mWebView?.evaluateJavaScript("playAudio()") { (data, error) in
        }
    }
    func pausePlay(){
        mWebView?.evaluateJavaScript("pauseAudio()") { (data, error) in
        }
    }

}

extension MainController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
