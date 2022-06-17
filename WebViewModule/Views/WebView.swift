//
//  WebView.swift
//  DKOTC
//
//  Created by po feng Lin on 2021/7/8.
//

import Foundation
import WebKit

class WebView {
    
    var mWebView = WKWebView()
    public func initView(mFrame: CGRect){

        // 禁止縮放
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);";
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController: WKUserContentController = WKUserContentController()
        userContentController.addUserScript(script)
        
        
        let pauseJSString:String =
        """
        var audios = document.getElementsByTagName("audio");
        function playAudio(){
            var len = audios.length
            for(var i=0;i<len;i++){
                audios[i].play();
            }
        }
        function pauseAudio(){
            var len = audios.length
            for(var i=0;i<len;i++){
                audios[i].pause();
            }
        }
        """
        let pauseJS:WKUserScript = WKUserScript.init(source: pauseJSString, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        userContentController.addUserScript(pauseJS)
        
        
        let conf = WKWebViewConfiguration()
        conf.userContentController = userContentController
        // 開啟播放
        conf.allowsInlineMediaPlayback = true
        conf.allowsAirPlayForMediaPlayback = true
        if #available(iOS 10.0, *) {
            conf.mediaTypesRequiringUserActionForPlayback = []
        } else {
            // Fallback on earlier versions
            conf.mediaPlaybackRequiresUserAction = false
        }
    
        mWebView = WKWebView(frame: mFrame, configuration: conf)
    }
    
    public func getWebView() -> WKWebView {
        return mWebView
    }

}
