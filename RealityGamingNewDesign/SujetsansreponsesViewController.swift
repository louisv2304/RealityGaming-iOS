//
//  SujetsansreponsesViewController.swift
//  RealityGamingNewDesign
//
//  Created by Marentdev on 21/08/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit
var other_start:Bool = false
class SujetsansreponsesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var discussions_titre:[String] = []
    var discussions_id:[String] = []
    var discussions_style:[String] = []
    var discussions_auteur:[String] = []
    var discussions_auteur_id:[String] = []
    var discussions_nbrep:[String] = []
    var ready:Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        getPage()
        // Do any additional setup after loading the view.
    }
    func getPage()
    {
        let link:String = "https://realitygaming.fr/sans-reponses/threads"
        session.request(URL(string: link)!, method: .get, parameters: nil).responseString { (responce) in
            
            let html = responce.result.value!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n", with: "")
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
            print(self.discussions_nbrep)
            print("AZERTY\(travaille_discussion_auteurid)")
            print(self.discussions_style)
            print(self.discussions_titre)
            print(self.discussions_auteur)
            print(self.discussions_auteur_id)
            print(self.discussions_id)
            self.ready = true
            self.tableView.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.discussions_titre.count == 0) {
            tableView.separatorStyle = .none
        }else {
            tableView.separatorStyle = .singleLine
        }
        return self.discussions_titre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell()
        if ready {
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id_threads = self.discussions_id[indexPath.row]
        other_start = true
        let next:TopicViewViewController = storyboard?.instantiateViewController(withIdentifier: "ViewTopic") as! TopicViewViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    


}
