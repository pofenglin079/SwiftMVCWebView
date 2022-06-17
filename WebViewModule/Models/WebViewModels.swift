//
//  WebViewModels.swift
//  DKOTC
//
//  Created by po feng Lin on 2021/7/8.
//

import Foundation

class WebViewModel{
    var url : String = ""
    
    func getUrlString() -> String {
        return self.url
    }
    
    func setUrlString(mUrl:String) {
        self.url = mUrl
    }
}
