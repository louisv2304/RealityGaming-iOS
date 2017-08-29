//
//  RealityGaming.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 27/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import Foundation
import SwiftIconFont

public class RealityGaming {
    
    func setRank(id:Int) -> [Any] {
        switch id {
        case 2: //Membre
            return ["" as! String, UIColor(rgb: 0x417394)]
        case 9: //Premium
            return ["" as! String, UIColor(rgb: 0xF9A600)]
        case 38: //VIP
            return [String.fontAwesomeIcon("star-o") as! String, UIColor(rgb: 0xF9A600)]
        case 19: //Ancien staff
            return [String.fontAwesomeIcon("star") as! String, UIColor(rgb: 0xFC7F3C)]
        case 55: //Rédacteur
            return [String.fontAwesomeIcon("pencil") as! String, UIColor(rgb: 0xA101A6)]
        case 40: //GlitchsHacksFR
            return [String.fontAwesomeIcon("youtube-play") as! String, UIColor(rgb: 0x2D9500)]
        case 39: //Assistants
            return ["", UIColor(rgb: 0x006D80)]
        case 4: //Modérateurs
            return [String.fontAwesomeIcon("gavel") as! String, UIColor.black]
        case 85: //Super-modérateurs
            return [String.fontAwesomeIcon("shield") as! String, UIColor(rgb: 0x054667)]
        case 66: //Développeurs
            return [String.fontAwesomeIcon("terminal") as! String, UIColor(rgb: 0xA70000)]
        case 3:  //Administrateur:
            return [String(format: "%C", 0xf27e), UIColor(rgb: 0xFF0000)]
        case 92: //Donateur
            return [String.fontAwesomeIcon("gift") as! String, UIColor(rgb: 0xF9A600)]
        case 94: //Rédacteur Twitter
            return [String.fontAwesomeIcon("twitter") as! String, UIColor(rgb: 0xA101A6)]
        case 95: //GlitchsHacksFR Twitter
            return [String.fontAwesomeIcon("twitter") as! String, UIColor(rgb: 0x2D9500)]
        case 91: //GlitchsHacksFR Ancien staff
            return [String.fontAwesomeIcon("youtube-play") as! String, UIColor(rgb: 0xFC7F3C)]
        case 88: //Premium découverte
            return [String.fontAwesomeIcon("clock-o") as! String, UIColor(rgb: 0xF9A600)]
        case 6: //Bannis
            return ["Strike" as! String, UIColor(rgb: 0x417394)]
        default:
            return ["dont found" as! String, UIColor.clear]
        }
    }
    
}
