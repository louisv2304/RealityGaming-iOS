//
//  SousForumsViewController.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 22/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit
import Alamofire
let rg:RealityGaming = RealityGaming()
class SousForumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var NavigationBar: UINavigationBar!
    @IBOutlet weak var tableview: UITableView!
    var ready:Bool = false
    var isCategories:Bool = true
    var forums_titre:[String] = []
    var forums_id:[String] = []
    var discussions_titre:[String] = []
    var discussions_id:[String] = []
    var discussions_style:[String] = []
    var discussions_auteur:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavigationBar.items?[0].title = forum_select_name
        isCategories = true
        getPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getPage() {
        var link:String = "https://realitygaming.fr/categories/\(forum_select_id)"
        if !isCategories {
            link = "https://realitygaming.fr/forums/\(forum_select_id)"
        }
        session.request(URL(string: link)!, method: .get, parameters: nil).responseString { (responce) in
            
            let html = responce.result.value!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n", with: "")
            let travaille_titre = function.matches(for: "<h3 class=nodeTitle>(.*?)</h3>", in: html)
            if html.contains("RealityGaming - Erreur") && html.contains("La catégorie demandée n'a pu être trouvée.") {
                self.isCategories = false
                self.getPage()
            }
            for var i in 0 ..< travaille_titre.count {
                let a = travaille_titre[i].replacingOccurrences(of: "<h3 class=nodeTitle>", with: "").replacingOccurrences(of: "</h3>", with: "")
                if !a.contains("Les membres ont trouvé cette page en recherchant"){
                self.forums_titre.append(function.GetElement(input: a as NSString, paternn: ">(.*?)</a>").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: "</a", with: ""))
                }
            }
            let travaille_forums_titre = function.matches(for: "<h3 class=title>(.*?)</h3>", in: html)
            for var i in 0 ..< travaille_forums_titre.count {
                let a = travaille_forums_titre[i].replacingOccurrences(of: "<h3 class=title>", with: "").replacingOccurrences(of: "</h3>", with: "")
                self.discussions_titre.append(function.GetElement(input: a as NSString, paternn: "/preview>(.*?)</a").replacingOccurrences(of: "/preview>", with: "").replacingOccurrences(of: "</a", with: ""))
            }
            let travaille_discussion_style = function.matches(for: "title=Auteur de la discussion>(.*?)>", in: html)
            for var i in 0 ..< travaille_discussion_style.count {
                var a = function.GetElement(input: travaille_discussion_style[i] as NSString, paternn: "style(.*?)>")
                if a == "" {
                    a = "2"
                }
                self.discussions_style.append(a.replacingOccurrences(of: "style", with: "").replacingOccurrences(of: ">", with: ""))
            }
            let travaille_discussion_author = function.matches(for: "<li id=thread-(.*?)>", in: html)
            for var i in 0 ..< travaille_discussion_author.count {
                var a = function.GetElement(input: travaille_discussion_author[i] as NSString, paternn: "author=(.*?)>")
                self.discussions_auteur.append(a.replacingOccurrences(of: "author=", with: "").replacingOccurrences(of: ">", with: ""))
            }
            print(self.discussions_style)
            print(self.discussions_titre)
            print(self.forums_titre)
            print(self.discussions_auteur)
            self.ready = true
            self.tableview.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiview = Bundle.main.loadNibNamed("HeaderSousForums", owner: nil, options: nil)?.first as! HeaderSousForums
        uiview.Titre.text = "Forums"
        if section == 1 {
            uiview.Titre.text = "Discussions"
        }
        return uiview
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 65
        }else {
            return 94
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.forums_titre.count
        }else {
            return self.discussions_titre.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell()
        if ready {
        if indexPath.section == 0 {
           let cella = tableView.dequeueReusableCell(withIdentifier: "forums", for: indexPath) as! ForumsTableViewCell
            cella.Titre.text = function.Clean_string(text: self.forums_titre[indexPath.row])
            cell = cella
            
        }else {
           let cellb = tableView.dequeueReusableCell(withIdentifier: "discussions", for: indexPath) as! DiscussionsTableViewCell
            cellb.Titre.text = function.Clean_string(text: self.discussions_titre[indexPath.row])
            cellb.Fa.text = rg.setRank(id: Int(self.discussions_style[indexPath.row])!)[0] as! String
            cellb.Fa.textColor = rg.setRank(id: Int(self.discussions_style[indexPath.row])!)[1] as! UIColor
            cellb.Auteur.textColor = rg.setRank(id: Int(self.discussions_style[indexPath.row])!)[1] as! UIColor
            cellb.Auteur.text = function.Clean_string(text: self.discussions_auteur[indexPath.row])
            
            cell = cellb
            
        }
        }
        return cell
        
    }
  
}
