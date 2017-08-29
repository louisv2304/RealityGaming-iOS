//
//  TopicViewViewController.swift
//  RealityGamingNewDesign
//
//  Created by Marentdev on 18/08/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit
var id_threads:String = ""
var isapost = false
class TopicViewViewController: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var Webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showWaitOverlayWithText("Chargement...")
        if isapost {
            Webview.loadRequest(URLRequest(url: URL(string: "https://realitygaming.fr/posts/\(id_threads)/")!))
        }else {
            Webview.loadRequest(URLRequest(url: URL(string: "https://realitygaming.fr/threads/\(id_threads)/")!))
        }
        
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(TopicViewViewController.returnto))
        tap.direction = .right
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    func returnto() {
        if !other_start {
            let next:SousForumsViewController = storyboard?.instantiateViewController(withIdentifier: "ForumsSelect") as! SousForumsViewController
            // self.navigationController?.pushViewController(next, animated: true)
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            transition.type = kCATransitionReveal
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.stringByEvaluatingJavaScript(from: "$('div.ads4').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.ads2').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.ads1').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.ads').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div#headerProxy').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.breadBoxTop').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.breadBoxBottom').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('footer').remove();")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.background = 'white'")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('html')[0].style.background = 'white'")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByClassName('pageContent')[0].style.background = 'white'")
        webView.stringByEvaluatingJavaScript(from: "document.getElementsByClassName('mainContent')[0].style.margin = '0'")
        webView.stringByEvaluatingJavaScript(from: "$('div.sharePage.advertising.sharePageBottom').remove();")
        webView.stringByEvaluatingJavaScript(from: "$('div.nodeInfo.categoryNodeInfo.categoryStrip')[0].style.backgroundColor = '#2980b9';")
        webView.stringByEvaluatingJavaScript(from: "$('div.nodeInfo.categoryNodeInfo.categoryStrip')[0].style.borderColor = 'transparent';")
        webView.stringByEvaluatingJavaScript(from: "$('head').append('<style>.nodeList .categoryStrip { border-bottom: 3px solid #2980b9!important;}::-webkit-scrollbar-thumb {background: #2980b9;}</style>');")
        self.Webview.isHidden = false
        //Some stuff
        self.removeAllOverlays()
    }
    

}
