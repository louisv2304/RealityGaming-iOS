//
//  AccueilViewController.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 08/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit
import SideMenu
class AccueilViewController: UIViewController, UIWebViewDelegate {
   
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var shoutbox: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuPresentMode = .viewSlideOut
        SideMenuManager.menuShadowRadius = 3
        shoutbox.isHidden = true
        shoutbox.loadRequest(URLRequest(url: URL(string: "https://realitygaming.fr/chatbox")!))
        self.showWaitOverlayWithText("Chargement...")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.stringByEvaluatingJavaScript(from: "$('div.ads4').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.ads2').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.ads1').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.ads').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div#headerProxy').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.breadBoxTop').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.breadBoxBottom').remove();")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('aside')[0].style.display = 'none';")
        webView.stringByEvaluatingJavaScript(from: "$('footer').remove();")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.background = 'white'")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('html')[0].style.background = 'white'")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByClassName('pageContent')[0].style.background = 'white'")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByClassName('mainContent')[0].style.margin = '0'")
        webView.stringByEvaluatingJavaScript(from: "$('div.sharePage.advertising.sharePageBottom').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.nodeInfo.categoryNodeInfo.categoryStrip')[0].style.backgroundColor = '#2980b9';")
        webView.stringByEvaluatingJavaScript(from: "$('div.nodeInfo.categoryNodeInfo.categoryStrip')[0].style.borderColor = 'transparent';")
        webView.stringByEvaluatingJavaScript(from: "$('head').append('<style>.nodeList .categoryStrip { border-bottom: 3px solid #2980b9!important;}::-webkit-scrollbar-thumb {background: #2980b9;}</style>');")
        self.shoutbox.isHidden = false
        self.removeAllOverlays()
        
    }
   

}
