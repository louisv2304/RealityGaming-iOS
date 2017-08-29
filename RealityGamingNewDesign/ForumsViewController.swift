//
//  ForumsViewController.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 16/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit
import Alamofire
import ExpandingMenu
import SwiftIconFont
var forum_select_id:Int = 0
var forum_select_name:String = ""
class ForumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var settingsButton: UIButton!
    var ready:Bool = false
    let forums_title:[String] = ["Forums généraux", "Réalité virtuelle", "Zone premium", "Plateformes", "Jeux-vidéo", "Teams et clans", "Compétition", "Divers"]
    let forums:[String] = ["RealityGaming", "Discussions générales", "Informatique", "Mobiles et tablettes", "Infographie", "Vidéos, musiques et chaînes", "Youpass", "Discussions générales réalité virtuelle", "Développement réalité virtuelle", "Equipements", "Jeux réalité virtuelle", "Général [Premium]", "Gaming [Premium]", "Informatique [Premium]", "Graphisme & Design [Premium]", "Bons plans & Reviews [Premium]", "Corbeille [Premium]", "PlayStation 4", "PlayStation 3", "Xbox One", "Xbox 360", "Wii & Wii U", "PC", "Consoles portables", "Call of Duty", "Grand Theft Auto", "FIFA", "Battlefield", "Minecraft", "League of Legends", "Destiny", "Counter strike", "Assasin's Creed", "Tom Clancy's", "Watch Dogs", "Garry's Mod", "Jeux de sport", "MMORPG", "Autres jeux", "Discussions équipes", "Recrutements", "Recherches d'équipes", "Rechers diverses", "Dexerto", "eSniping", "Corbeille"]
    var forums_autres:[String] = []
    
    @IBOutlet weak var Test: UIBarButtonItem!
    @IBOutlet weak var tableview: UITableView!
    let forums_images:[UIImage] = [#imageLiteral(resourceName: "RealityGaming"), #imageLiteral(resourceName: "Discussion generales"), #imageLiteral(resourceName: "Informatique"), #imageLiteral(resourceName: "Mobiles et tablettes"), #imageLiteral(resourceName: "Infographie"),#imageLiteral(resourceName: "Videos, musiques et chaines"), #imageLiteral(resourceName: "YouPass"), #imageLiteral(resourceName: "Discussion generales"), #imageLiteral(resourceName: "Discussion generales"), #imageLiteral(resourceName: "Discussion generales"), #imageLiteral(resourceName: "Discussion generales"), /* premium */#imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales")/*end*/, #imageLiteral(resourceName: "PS4"), #imageLiteral(resourceName: "PS3"), #imageLiteral(resourceName: "Xbox One"), #imageLiteral(resourceName: "Xbox 360"), #imageLiteral(resourceName: "Wii"), #imageLiteral(resourceName: "Informatique"), #imageLiteral(resourceName: "Consoles portables"), #imageLiteral(resourceName: "Discussion generales"), #imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Minecraft"), #imageLiteral(resourceName: "LoL"),#imageLiteral(resourceName: "Destiny"), #imageLiteral(resourceName: "CSGO"), #imageLiteral(resourceName: "Assasin"), #imageLiteral(resourceName: "Tom Clancy"), #imageLiteral(resourceName: "Discussion generales"),#imageLiteral(resourceName: "Discussion generales"), #imageLiteral(resourceName: "JeuxDeSport"), #imageLiteral(resourceName: "Discussion generales"), #imageLiteral(resourceName: "Autres jeux"), #imageLiteral(resourceName: "Disc Equipes"), #imageLiteral(resourceName: "Recrutements"), #imageLiteral(resourceName: "Recherche equipes"), #imageLiteral(resourceName: "Recherches diverses"), #imageLiteral(resourceName: "Competitions"), #imageLiteral(resourceName: "Competitions"), #imageLiteral(resourceName: "Discussion generales") ]
    
    let forums_id:[Int] = [3,17,443,490,59,442,812,0,824,745,0,67,83,587,171,783,558,441,439,438,437,434,25,129,42,517,759,481,108,601,590,482,311,709,565,799,187,343,99,380,381,382,383,398,399,281]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: settingsButton.frame.origin, size: CGSize(width: 25, height: 25)), centerImage: #imageLiteral(resourceName: "menu"), centerHighlightedImage: #imageLiteral(resourceName: "menu"))
        menuButton.center = CGPoint(x: settingsButton.layer.position.x + 32, y: settingsButton.layer.position.y + 28)
        menuButton.expandingDirection = .bottom
        view.addSubview(menuButton)
        let item1 = ExpandingMenuItem(size: menuButton.frame.size, title: "Sujets sans réponses", image: #imageLiteral(resourceName: "speech-bubble"), highlightedImage: #imageLiteral(resourceName: "speech-bubble"), backgroundImage: nil, backgroundHighlightedImage: nil) { () -> Void in
            let next:SujetsansreponsesViewController = self.storyboard?.instantiateViewController(withIdentifier: "Sujetsansrep") as! SujetsansreponsesViewController
            self.navigationController?.pushViewController(next, animated: true)
        }
        let item2 = ExpandingMenuItem(size: menuButton.frame.size, title: "Nouveaux messages", image: #imageLiteral(resourceName: "speech-bubble-new"), highlightedImage: #imageLiteral(resourceName: "speech-bubble-new"), backgroundImage: nil, backgroundHighlightedImage: nil) { () -> Void in
            // Do some action
        }
        let item3 = ExpandingMenuItem(size: menuButton.frame.size, title: "Marquer les forums comme lus", image: #imageLiteral(resourceName: "speech-bubble-lu"), highlightedImage: #imageLiteral(resourceName: "speech-bubble-lu"), backgroundImage: nil, backgroundHighlightedImage: nil) { () -> Void in
            // Do some action
        }
        let item4 = ExpandingMenuItem(size: menuButton.frame.size, title: "Dernières actualités", image: #imageLiteral(resourceName: "text-lines"), highlightedImage: #imageLiteral(resourceName: "text-lines"), backgroundImage: nil, backgroundHighlightedImage: nil) { () -> Void in
            // Do some action
        }
        menuButton.addMenuItems([item1, item2, item3, item4])
        getInfo()
    }
    func getInfo(){
        session.request(URL(string: "https://realitygaming.fr/")!, method: .get).responseString { (responce) in
            let html = responce.result.value!.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n", with: "")
            let travaille_forum_autres = function.matches(for: "<div class=nodeStats pairsInline>(.*?)<div", in: html)
            for var i in 0 ..< travaille_forum_autres.count {
                self.forums_autres.append(travaille_forum_autres[i].replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "<div class=nodeStats pairsInline><dl><dt>", with: "").replacingOccurrences(of: "</dd></dl><dl><dt>", with: "  ").replacingOccurrences(of: "</dt> <dd>", with: " ").replacingOccurrences(of: "<div", with: "").replacingOccurrences(of: "</dd></dl>", with: "").replacingOccurrences(of: "</div>", with: ""))
            }
            self.ready = true
            self.tableview.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiview = Bundle.main.loadNibNamed("HeaderForums", owner: nil, options: nil)?.first as! HeaderForums
        uiview.Titre.text = forums_title[section]
        if section == 2 {
            uiview.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        return uiview
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 43.5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forums_title.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        case 1:
            return 4
        case 2:
            return 6
        case 3:
            return 7
        case 4:
            return 15
        case 5:
            return 4
        case 6:
            return 2
        case 7:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "forums", for: indexPath) as! ForumsTableViewCell
        if ready {
        switch indexPath.section {
        case 0:
            cell.Titre.text = forums[indexPath.row]
            cell.Nodeicon.image = forums_images[indexPath.row]
            cell.Divers.text = forums_autres[indexPath.row]
            break
        case 1:
            cell.Titre.text = forums[indexPath.row + 7]
            cell.Nodeicon.image = forums_images[indexPath.row + 7]
            cell.Divers.text = forums_autres[indexPath.row + 7]
            break
        case 2:
            cell.Titre.text = forums[indexPath.row + 8 + 3]
            cell.Nodeicon.image = forums_images[indexPath.row + 8 + 3]
            cell.Divers.text = forums_autres[indexPath.row + 8 + 3]
            break
        case 3:
            cell.Titre.text = forums[indexPath.row + 12 + 5]
            cell.Nodeicon.image = forums_images[indexPath.row + 12 + 5]
            cell.Divers.text = forums_autres[indexPath.row + 12 + 5]
            break
        case 4:
            cell.Titre.text = forums[indexPath.row + 18 + 6]
            cell.Nodeicon.image = forums_images[indexPath.row + 18 + 6]
            cell.Divers.text = forums_autres[indexPath.row + 18 + 6]
            break
        case 5:
            cell.Titre.text = forums[indexPath.row + 25 + 14]
            cell.Nodeicon.image = forums_images[indexPath.row + 25 + 14]
            cell.Divers.text = forums_autres[indexPath.row + 25 + 14]
            break
        case 6:
            cell.Titre.text = forums[indexPath.row + 40 + 3]
            cell.Nodeicon.image = forums_images[indexPath.row + 40 + 3]
            cell.Divers.text = forums_autres[indexPath.row + 40 + 3]
            break
        case 7:
            cell.Titre.text = forums[indexPath.row + 44 + 1]
            cell.Nodeicon.image = forums_images[indexPath.row + 44 + 1]
            cell.Divers.text = forums_autres[indexPath.row + 44 + 1]
            break
        default:
            break
        }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            forum_select_name = forums[indexPath.row]
            forum_select_id = forums_id[indexPath.row]
            break
        case 1:
            forum_select_name = forums[indexPath.row + 7]
            forum_select_id = forums_id[indexPath.row + 7]
            break
        case 2:
            forum_select_name = forums[indexPath.row + 8 + 3]
            forum_select_id = forums_id[indexPath.row + 8 + 3]
            break
        case 3:
            forum_select_name = forums[indexPath.row + 12 + 5]
            forum_select_id = forums_id[indexPath.row + 12 + 5]
            break
        case 4:
            forum_select_name = forums[indexPath.row + 18 + 6]
            forum_select_id = forums_id[indexPath.row + 18 + 6]
            break
        case 5:
            forum_select_name = forums[indexPath.row + 25 + 14]
            forum_select_id = forums_id[indexPath.row + 25 + 14]
            break
        case 6:
            forum_select_name = forums[indexPath.row + 40 + 3]
            forum_select_id = forums_id[indexPath.row + 40 + 3]
            break
        case 7:
            forum_select_name = forums[indexPath.row + 44 + 1]
            forum_select_id = forums_id[indexPath.row + 44 + 1]
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let next:SousForumsViewController = storyboard?.instantiateViewController(withIdentifier: "ForumsSelect") as! SousForumsViewController
        self.navigationController?.pushViewController(next, animated: true)
    }

}
