//
//  SideMenuViewController.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 09/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit
import SwiftIconFont
import Alamofire
var Selection_Menu:[Bool] = [true, false, false, false, false, false, false, false, false, false]
class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let name:[String] = ["Shoutbox", "Forums", "Teams", "Games", "GlitchHacksFR", "Médias", "Services", "Tournois", "Membres", "Aide"]
    let FontAwesome:[String] = ["comments", "comments-o", "users", "gamepad", "youtube-play", "camera-retro", "shopping-cart", "trophy", "user", "info-circle"]
    /* UserPanel */
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Pseudo: UILabel!
    @IBOutlet weak var FaRank: UILabel!
    @IBOutlet weak var Messages: UILabel!
    @IBOutlet weak var Likes: UILabel!
    @IBOutlet weak var Points: UILabel!
    /* END-UserPanel*/
    override func viewDidLoad() {
        super.viewDidLoad()
        struct_userPanel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func struct_userPanel() {
        session.request(URL(string: "https://realitygaming.fr")!).responseString { (responce) in
            let html:String = responce.result.value!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n", with: "")
            print(html)
            let travaille_userpane = function.GetElement(input: html as NSString, paternn: "<div class=section visitorPanel>(.*?)</div").replacingOccurrences(of: "</div", with: "")
            print(travaille_userpane)
            self.Pseudo.text = function.GetElement(input: travaille_userpane as NSString, paternn: "alt=(.*?)>").replacingOccurrences(of: "alt=", with: "").replacingOccurrences(of: "/>", with: "")
            function.loadImageFromUrl(url: function.GetLinkAvtar(id: function.GetElement(input: html as NSString, paternn: "user_id:(.*?)serverTimeInfo:").replacingOccurrences(of: "user_id: ", with: "").replacingOccurrences(of: "},", with: "").replacingOccurrences(of: "serverTimeInfo:", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\t", with: "")), view: self.Avatar)
            self.Avatar.layer.masksToBounds = true
            self.Avatar.layer.cornerRadius = self.Avatar.frame.width / 2
            self.Avatar.isHidden = false
            let styleid:String = function.GetElement(input: travaille_userpane as NSString, paternn: "class=style(.*?)>").replacingOccurrences(of: "class=style", with: "").replacingOccurrences(of: ">", with: "") as String
            print(styleid)
           self.Pseudo.textColor = rg.setRank(id: Int(styleid)!)[1] as! UIColor
            self.FaRank.textColor = rg.setRank(id: Int(styleid)!)[1] as! UIColor
            self.FaRank.text = rg.setRank(id: Int(styleid)!)[0] as? String
            self.Messages.text = function.GetElement(input: html as NSString, paternn: "<dl class=pairsJustified>Messages:(.*?)<dl class=pairsJustified>").replacingOccurrences(of: "<dl class=pairsJustified>Messages:", with: "").replacingOccurrences(of: " <dl class=pairsJustified>", with: "") as String
            self.Likes.text = function.GetElement(input: html as NSString, paternn: "<dl class=pairsJustified>Appréciations:(.*?)<dl class=pairsJustified>").replacingOccurrences(of: "<dl class=pairsJustified>Appréciations:", with: "").replacingOccurrences(of: " <dl class=pairsJustified>", with: "") as String
             self.Points.text = function.GetElement(input: html as NSString, paternn: "<dl class=pairsJustified>Points:(.*?) ").replacingOccurrences(of: "<dl class=pairsJustified>Points:", with: "") as String
            print(String(format: "%C", 0xf011))
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuSideTableViewCell
        
        cell.selectionStyle = .none
        
        tableView.separatorColor = UIColor.clear
        cell.Titre.text = name[indexPath.row]
        cell.Fa.text = String.fontAwesomeIcon(FontAwesome[indexPath.row])
        
        if Selection_Menu[indexPath.row]{
            cell.viewselect.backgroundColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
            cell.Titre.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
            cell.Fa.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
        }else {
            cell.viewselect.backgroundColor = UIColor.white
            cell.Titre.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
            cell.Fa.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for var i in 0 ..< Selection_Menu.count    {
            if Selection_Menu[i] == true {
                Selection_Menu[i] = false
                let index = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: index) as! MenuSideTableViewCell
                cell.viewselect.backgroundColor = UIColor.white
                cell.Titre.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
                cell.Fa.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
            }
        }
        let cell = tableView.cellForRow(at: indexPath) as! MenuSideTableViewCell
        cell.viewselect.backgroundColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
        cell.Titre.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
        cell.Fa.textColor = #colorLiteral(red: 0.190430969, green: 0.4948838353, blue: 0.7447223663, alpha: 1)
        Selection_Menu[indexPath.row] = true
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let next:AccueilViewController = storyboard?.instantiateViewController(withIdentifier: "Shoutbox") as! AccueilViewController
        self.navigationController?.pushViewController(next, animated: true)

            break
        case 1:
            let next:ForumsViewController = storyboard?.instantiateViewController(withIdentifier: "Forums") as! ForumsViewController
            self.navigationController?.pushViewController(next, animated: true)

            break
        default:
            break
        }
    }
    @IBAction func DeconnexionRG(_ sender: UIButton) {
        let parametres:Parameters = ["_xfToken":_xfToken]
        session.request(URL(string: "https://realitygaming.fr/logout")!, method: .get, parameters: parametres, encoding: URLEncoding.default, headers: nil).responseString { (responce) in
            self.performSegue(withIdentifier: "start", sender: self)
        }
    }
}
