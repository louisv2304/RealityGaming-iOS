//
//  Functions.swift
//  MangaKai
//
//  Created by Marent on 13/11/2016.
//  Copyright © 2016 Marent. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil) else { return nil }
        return html
    }
}
extension UILabel {
    func setStrikethrough(text:String, color:UIColor){
        let attributedText = NSAttributedString(string: text, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSStrikethroughColorAttributeName: color])
        self.attributedText = attributedText
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
class Functions {

       /* func Alertes_Check(){
        var msg:String!
        var nb:String!
        session.request(URL(string: "https://realitygaming.fr/account/privacy-save")!, method: .post, parameters: ["_xfResponseType":"json"]).responseString { (respond) in
        //Do Something
            let html = respond.result.value!.replacingOccurrences(of: "\"", with: "")
            nb = self.GetElement(input: html as NSString, paternn: "_visitor_alertsUnread:(.+)").replacingOccurrences(of: "_visitor_alertsUnread:", with: "").replacingOccurrences(of: "}", with: "")
            msg = "Vous avez: \(nb as! String) alertes non lus"
            if msg.contains("1 ") || msg.contains("0"){
                msg = "Vous avez: \(nb as! String) alerte non lu"
            }
            
            let banner:Banner = Banner(title: "RealityGaming | Alertes", subtitle: msg, image: nil, backgroundColor: UIColor(hex: 0x82A9BC)) {
                print("ok")
            }
            banner.show(duration: 3.0)
            
        }
        
    }
    func Conversation_Check(){
        var msg:String!
        var nb:String!
        sessionManager.request(URL(string: "https://realitygaming.fr/account/privacy-save")!, method: .post, parameters: ["_xfResponseType":"json"]).responseString { (respond) in
            //Do Something
            let html = respond.result.value!.replacingOccurrences(of: "\"", with: "")
            nb = self.GetElement(input: html as NSString, paternn: "_visitor_conversationsUnread:(.*?),").replacingOccurrences(of: "_visitor_conversationsUnread:", with: "").replacingOccurrences(of: ",", with: "")
            msg = "Vous avez: \(nb as! String) conversations non lus"
            if msg.contains("1 ") || msg.contains("0"){
                msg = "Vous avez: \(nb as! String) conversation non lu"
            }
            
            let banner:Banner = Banner(title: "RealityGaming | Conversations", subtitle: msg, image: nil, backgroundColor: UIColor(hex: 0x82A9BC)) {
                print("ok")
            }
            banner.show(duration: 3.0)
            
        }
        
    }*/
    
    func GetLinkAvtar(id:String) -> String {
        var link:String = "https://realitygaming.fr/data/avatars/l/"
        var id1 = ""
        let a:NSString = id as NSString
        if (id.characters.count == 6){
            id1 = a.substring(to: 3)
        }
        else if (id.characters.count == 5){
            id1 = a.substring(to: 2)
        }
        else if (id.characters.count == 4){
            id1 = a.substring(to: 1)
        }
        else{
            id1 = "0"
        }
        link = "https://realitygaming.fr/data/avatars/l/\(id1 as String)/\(id as String).jpg"
        
        if link == "https://realitygaming.fr/data/avatars/l/0/.jpg"{
            link = "https://realitygaming.fr/styles/realitygaming/xenforo/avatars/avatar_male_l.png"
        }
        return link
    }
    func Clean_string(text:String) -> String{
        let decodedString = text.htmlAttributedString()?.string
        return decodedString! as String
    }
    
   /* func AlertForumsLus(){
        let alert:SCLAlertView = SCLAlertView()
        alert.addButton("Valider") {
            
            sessionManager.request(URL(string: "https://realitygaming.fr/forums/-/mark-read")!, method: .get).responseString(completionHandler: { (responds) in
                let dataString:String = NSString(data: responds.data!, encoding: String.Encoding.utf8.rawValue) as! String
                let html = dataString.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\"", with: "")
                let code = function.GetElement(input: html as NSString, paternn: "input type=hidden name=date value=(.*?)>").replacingOccurrences(of: "input type=hidden name=date value=", with: "").replacingOccurrences(of: "/>", with: "")
                sessionManager.request(URL(string: "https://realitygaming.fr/forums/-/mark-read")!, method: .post, parameters: ["date":code as String, "_xfToken":TokenRG,"_xfConfirm":"1"]).responseString(completionHandler: { (responds) in
                    //Do nothing
                })
            })
        
        }
        alert.appearance.showCloseButton = false
        alert.addButton("Close") { 
        //Close
        }
        alert.showInfo("Marquer les forums comme lus", subTitle: "Êtes-vous certain de vouloir marquer tous les forums comme lus ?")
    }*/
   /* func setupmenuside(){
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuShadowRadius = 0
        
    }*/
    func matches(for regex: String!, in text: String!) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    func loadImageFromUrl(url: String, view: UIImageView){
        let url = NSURL(string: url)!
        let task =  URLSession.shared.dataTask(with: url as URL) { (responseData, responseUrl, error) -> Void in
            if let data = responseData{
                DispatchQueue.main.async(execute: { () -> Void in
                    if data.base64EncodedString() == "PCFET0NUWVBFIGh0bWw+CjxodG1sIGlkPSJSZWFsaXR5R2FtaW5nIiBsYW5nPSJmci1GUiIgZGlyPSJMVFIiPgo8aGVhZD4KPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPgo8bWV0YSBodHRwLWVxdWl2PSJYLVVBLUNvbXBhdGlibGUiIGNvbnRlbnQ9IklFPUVkZ2UsY2hyb21lPTEiPgo8bWV0YSBuYW1lPSJ2aWV3cG9ydCIgY29udGVudD0id2lkdGg9ZGV2aWNlLXdpZHRoLCBpbml0aWFsLXNjYWxlPTEsIGhlaWdodD1kZXZpY2UtaGVpZ2h0Ij4KPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL2Rldi5yZWFsaXR5Z2FtaW5nLnRlY2gvcmVhbGl0eWdhbWluZy5jc3MiLz4KPGxpbmsgcmVsPSJzdHlsZXNoZWV0IiBocmVmPSIvL2ZvbnRzLmdvb2dsZWFwaXMuY29tL2Nzcz9mYW1pbHk9T3BlbitTYW5zIi8+CjxsaW5rIHJlbD0ic3R5bGVzaGVldCIgaHJlZj0iLy9tYXhjZG4uYm9vdHN0cmFwY2RuLmNvbS9mb250LWF3ZXNvbWUvNC43LjAvY3NzL2ZvbnQtYXdlc29tZS5taW4uY3NzIi8+Cjx0aXRsZT4KRXJyZXVyIDQwNCB8IFJlYWxpdHlHYW1pbmcgPC90aXRsZT4KPC9oZWFkPgo8Ym9keT4KPGRpdiBjbGFzcz0iaGVhZGVycGciPgo8aW1nIGNsYXNzPSJyZ0xvZ28iIHNyYz0iL3N0eWxlcy9yZWFsaXR5Z2FtaW5nL2xvZ28uc3ZnIj4KPC9kaXY+CjxkaXYgY2xhc3M9ImNvbnRhaW5lciI+CjxkaXYgY2xhc3M9ImNvbnRlbnQiPgo8cCBjbGFzcz0idGV4dEhlYWRpbmciPgpFcnJldXIgNDA0IDwvcD4KPGgyIGNsYXNzPSJpY29uRXJyb3IiPjxpIGNsYXNzPSJmYSBmYS1leGNsYW1hdGlvbi10cmlhbmdsZSI+PC9pPjwvaDI+CjxwIGNsYXNzPSJpbmZvcm1hdGl2ZVRleHQiPgpOYXZyw6kgISBDZXR0ZSBwYWdlIG4nZXhpc3RlIHBhcyBvdSBwbHVzLiA8L3A+CjxhIGhyZWY9Ii9pbmRleC5waHAiIGNsYXNzPSJidG4gY2hlY2siPjxzcGFuPjxpIGNsYXNzPSJmYSBmYS1ob21lIj48L2k+PC9zcGFuPlJldG91ciBhdSBzaXRlPC9hPgo8L2Rpdj4KPC9kaXY+CjxkaXYgaWQ9ImZvb3RlciI+CjxkaXYgY2xhc3M9ImZvb3RlclRleHQiPgo8YSBocmVmPSIvL2ZhY2Vib29rLmNvbS9SZWFsaXR5R2FtaW5nRlIiIHRpdGxlPSJTdWl2ZXogUmVhbGl0eUdhbWluZyBzdXIgRmFjZWJvb2sgYWZpbiBkZSByZXN0ZXIgYXUgY291cmFudCBkZXMgZGVybmnDqHJlcyBub3V2ZWF1dMOpcyAhIiB0YXJnZXQ9Il9ibGFuayI+PHNwYW4gY2xhc3M9ImZhY2Vib29rIj48L3NwYW4+PC9hPgo8YSBocmVmPSIvL3R3aXR0ZXIuY29tL1JlYWxpdHlHYW1pbmdGUiIgdGl0bGU9IlN1aXZleiBSZWFsaXR5R2FtaW5nIHN1ciBGYWNlYm9vayBhZmluIGRlIHJlc3RlciBhdSBjb3VyYW50IGRlcyBkZXJuacOocmVzIG5vdXZlYXV0w6lzICEiIHRhcmdldD0iX2JsYW5rIj48c3BhbiBjbGFzcz0idHdpdHRlciI+PC9zcGFuPjwvYT4KPC9kaXY+CjwvZGl2Pgo8L2JvZHk+CjwvaHRtbD4K"{
                        view.image = nil
                    }else {
                        view.image = UIImage(data: data)
                    }
                    
                    
                })
            }
        }
        task.resume()
    }
    func GetElement(input:NSString, paternn:NSString) -> NSString {
        let azerty:NSString = input.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "</dd></dl>", with: " ").replacingOccurrences(of: "</dt> <dd>", with: "").replacingOccurrences(of: "pairsJustified><dt>", with: "pairsJustified>") as NSString
        let cowRegex = try! NSRegularExpression(pattern: paternn as String,
                                                options: .caseInsensitive)
        
        
        if let cowMatch = cowRegex.firstMatch(in: azerty as String, options: [],
                                              range: NSMakeRange(0, azerty.length)) {
            let tokenrg:NSString = (azerty as NSString).substring(with: cowMatch.range) as NSString
            return tokenrg
            
        }else{
            return ""
        }
    }
  /*  func RankColor(num:String) -> UIColor {
        switch num.replacingOccurrences(of:" ",with:"") {
        case "3":
            return UIColor.red
        case "66":
            return UIColor(hex: 0xA70000)
        case "85":
            return UIColor(hex: 0x054667)
        case "4":
            return UIColor.black
        case "39":
            return UIColor(hex: 0x006d80)
        case "40":
            return UIColor(hex: 0x2d9500)
        case "55":
            return UIColor(hex: 0xa101a6)
        case "89":
            return UIColor(hex: 0x7d8a8b)
        case "19":
            return UIColor(hex: 0xFC7F3C)
        case "38":
            return UIColor(hex: 0xf9a600)
        case "9":
            return UIColor(hex: 0xf9a600)
        case "92":
            return UIColor(hex: 0xf9a600)
        case "84":
            return UIColor(hex: 0xf9a600)
        case "83":
            return UIColor.black
        case "88":
            return UIColor(hex: 0xf9a600)
        case "91":
            return UIColor(hex: 0xFC7F3C)
        case "94":
              return UIColor(hex: 0xa101a6)
        default:
            return UIColor(hex: 0x417394)
        }
    }
    func RankFa(num:String) -> FAType {
        switch num.replacingOccurrences(of:" ",with:"") {
        case "3":
            return FAType.FABlackTie
        case "66":
            return FAType.FATerminal
        case "85":
            return FAType.FAShield
        case "4":
            return FAType.FAGavel
        case "39":
            return FAType.FAGraduationCap
        case "40":
            return FAType.FAYoutubePlay
        case "91":
            return FAType.FAYoutubePlay
        case "55":
            return FAType.FAPencil2
        case "89":
            return FAType.FACommentO
        case "19":
            return FAType.FAStar
        case "38":
            return FAType.FAStarO
        case "84":
            return FAType.FATwitter
        case "9":
            return FAType.FAClear
        case "83":
            return FAType.FATwitter
        case "88":
            return FAType.FAClockO
        case "92":
            return FAType.FAGift
        case "94":
            return FAType.FATwitter
        default:
            return FAType.FAClear
        }
    }
    func PrefixBack(name:String) -> UIImage {
        switch name {
        case "prefixSond":
            return #imageLiteral(resourceName: "Sondage")
        case "prefixImp":
            return #imageLiteral(resourceName: "Important")
        case "prefixNews":
            return #imageLiteral(resourceName: "Nouveaute")
        case "prefixAcc":
            return #imageLiteral(resourceName: "Acceptée")
        case "prefixRef":
            return #imageLiteral(resourceName: "Important")
        case "prefixAtt":
            return #imageLiteral(resourceName: "En_attente")
        case "prefixResolu":
            return #imageLiteral(resourceName: "Acceptée")
        case "prefixTuto":
            return #imageLiteral(resourceName: "Tutoriel")
        case "prefixSpoil":
            return #imageLiteral(resourceName: "Important")
        case "prefixQues":
            return #imageLiteral(resourceName: "Question")
        case "prefixFilm":
            return #imageLiteral(resourceName: "Nouveaute")
        case "prefixNews":
            return #imageLiteral(resourceName: "Nouveaute")
        default:
            return #imageLiteral(resourceName: "En_attente")
        }
    }
    func PrefixFA(name:String) -> FAType {
        switch name {
        case "prefixSond":
            return .FABarChart
        case "prefixImp":
            return .FAExclamationCircle
        case "prefixAcc":
            return .FACheckSquare
        case "prefixRef":
            return .FATimes
        case "prefixAtt":
            return .FARetweet
        case "prefixResolu":
            return .FACheck
        case "prefixTuto":
            return .FAFolderOpen
        case "prefixSpoil":
            return .FAEyeSlash
        case "prefixQues":
            return .FAQuestion
        case "prefixFilm":
            return .FAFilm
        case "prefixNews":
            return .FANewspaperO
        default:
            return FAType.FALock
        }

    }
    func PrefixString(name:String) -> String {
        switch name {
        case "prefixSond":
            return " Sondage"
        case "prefixImp":
            return " Important"
        case "prefixAcc":
            return " Acceptée"
        case "prefixRef":
            return " Refusée"
        case "prefixAtt":
            return " En Attente"
        case "prefixResolu":
            return " Résolu"
        case "prefixTuto":
            return " Tutoriel"
        case "prefixSpoil":
            return " Spoil"
        case "prefixQues":
            return " Question"
        case "prefixFilm":
            return " Film"
        case "prefixNews":
            return " News"
        default:
            return "Soon.."
        }
        
    }*/

}
