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
class SousForumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
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
    var discussions_auteur_id:[String] = []
    var discussions_nbrep:[String] = []
    var forums_autres:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavigationBar.items?[0].title = forum_select_name
        isCategories = true
        getPage()
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(TopicViewViewController.returnto))
        tap.direction = .right
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    func returnto() {
        let next:ForumsViewController = storyboard?.instantiateViewController(withIdentifier: "Forums") as! ForumsViewController
        // self.navigationController?.pushViewController(next, animated: true)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        transition.type = kCATransitionReveal
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(next, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func destroy_var()
    {
        self.discussions_id.removeAll()
        self.discussions_auteur_id.removeAll()
        self.discussions_auteur.removeAll()
        self.discussions_style.removeAll()
        self.discussions_titre.removeAll()
        self.forums_titre.removeAll()
        self.forums_id.removeAll()
        self.ready = false
    }
    func getPage() {
        self.destroy_var()
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
            let travaille_id = function.matches(for: "description=#nodeDescription-(.*?)>", in: html)
            for var i in 0 ..< travaille_id.count {
                self.forums_id.append(travaille_id[i].replacingOccurrences(of: "description=#nodeDescription-", with: "").replacingOccurrences(of: ">", with: ""))
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
            let travaille_discussion_auteurid = function.matches(for: "<div class=posterDate muted>(.*?)Auteur de la discussion>", in: html)
            for var i in 0 ..< travaille_discussion_auteurid.count {
                var a = ""
                let ok = travaille_discussion_auteurid[i].components(separatedBy: ".")
                if ok.count > 1 {
                    a = ok[1]
                }
                if a == "" {
                    a = "175291"
                }
                if travaille_discussion_auteurid[i].contains("href=jb/") {
                    a = "1"
                }
                if travaille_discussion_auteurid[i].contains("href=fabien/") {
                    a = "38138"
                }
                if travaille_discussion_auteurid[i] == "<div class=posterDate muted><a class=username dir=auto title=Auteur de la discussion>" {
                    a = "175291"
                }
                self.discussions_auteur_id.append(a.replacingOccurrences(of: "/ class=username dir=auto title=Auteur de la discussion>", with: "").replacingOccurrences(of: "s data-avatarhtml=true>", with: ""))
            }
            let travaille_discussion_id = function.matches(for: "id=thread-(.*?)class", in: html)
            for var i in 0 ..< travaille_discussion_id.count {
                let a = travaille_discussion_id[i].replacingOccurrences(of: "id=thread-", with: "").replacingOccurrences(of: "class", with: "").replacingOccurrences(of: " ", with: "")
                
                self.discussions_id.append(a)
            }
            let travaille_rep_discussion = function.matches(for: "<dl class=major><dt>Réponses:</dt> <dd>(.*?)</dd></dl>", in: html)
            for var i in 0 ..< travaille_rep_discussion.count {
                self.discussions_nbrep.append(travaille_rep_discussion[i].replacingOccurrences(of: "<dl class=major><dt>Réponses:</dt> <dd>", with: "").replacingOccurrences(of: "</dd></dl>", with: ""))
                
            }
            let travaille_forum_autres = function.matches(for: "<div class=nodeStats pairsInline>(.*?)<div", in: html)
            for var i in 0 ..< travaille_forum_autres.count {
                self.forums_autres.append(travaille_forum_autres[i].replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "<div class=nodeStats pairsInline><dl><dt>", with: "").replacingOccurrences(of: "</dd></dl><dl><dt>", with: "  ").replacingOccurrences(of: "</dt> <dd>", with: " ").replacingOccurrences(of: "<div", with: "").replacingOccurrences(of: "</dd></dl>", with: "").replacingOccurrences(of: "</div>", with: ""))
            }
            print(self.forums_autres)
            print(self.discussions_nbrep)
            print("AZERTY\(travaille_discussion_auteurid)")
            print(self.discussions_style)
            print(self.discussions_titre)
            print(self.forums_titre)
            print(self.discussions_auteur)
            print(self.discussions_auteur_id)
            print(self.forums_id)
            print(self.discussions_id)
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
            if (self.discussions_titre.count == 0) {
                tableView.separatorStyle = .none
            }else {
                tableView.separatorStyle = .singleLine
            }
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
            cella.Titre.text = self.forums_titre[indexPath.row]
            cella.Divers.text = self.forums_autres[indexPath.row]
            cella.Nodeicon.image = #imageLiteral(resourceName: "Discussion generales")
            cell = cella
            
        }else {
           let cellb = tableView.dequeueReusableCell(withIdentifier: "discussions", for: indexPath) as! DiscussionsTableViewCell
            cellb.Titre.text = function.Clean_string(text: self.discussions_titre[indexPath.row])
            cellb.Fa.text = rg.setRank(id: Int(self.discussions_style[indexPath.row])!)[0] as! String
            cellb.Fa.textColor = rg.setRank(id: Int(self.discussions_style[indexPath.row])!)[1] as! UIColor
            cellb.Auteur.textColor = rg.setRank(id: Int(self.discussions_style[indexPath.row])!)[1] as! UIColor
            cellb.Auteur.text = function.Clean_string(text: self.discussions_auteur[indexPath.row])
            function.loadImageFromUrl(url: function.GetLinkAvtar(id: self.discussions_auteur_id[indexPath.row]), view: cellb.Avatar)
            cellb.Avatar.layer.cornerRadius = cellb.Avatar.frame.width / 2
            cellb.Avatar.clipsToBounds = true
            cellb.forums.text = "Réponses: \(self.discussions_nbrep[indexPath.row])"
            if cellb.Fa.text == "Strike"{
                cellb.Auteur.setStrikethrough(text: function.Clean_string(text: self.discussions_auteur[indexPath.row]), color: rg.setRank(id: Int(self.discussions_style[indexPath.row])!)[1] as! UIColor)
                cellb.Fa.textColor = .clear
            }
            
            cell = cellb
        }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        other_start = false
        if indexPath.section == 0 {
            forum_select_id = Int(self.forums_id[indexPath.row])!
            let cell = tableView.cellForRow(at: indexPath) as! ForumsTableViewCell
            self.NavigationBar.items?[0].title = cell.Titre.text
            self.getPage()
        }
        else {
            id_threads = self.discussions_id[indexPath.row]
            let next:TopicViewViewController = storyboard?.instantiateViewController(withIdentifier: "ViewTopic") as! TopicViewViewController
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
  
}
