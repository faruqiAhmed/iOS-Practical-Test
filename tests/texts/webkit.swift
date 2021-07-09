//
//  webkit.swift
//  texts
//
//  Created by Md Omar Faruq on 7/9/21.
//

import Foundation
import WebKit
import  SwiftUI
struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
