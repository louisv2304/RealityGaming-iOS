//
//  ViewController.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 08/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
var _xfToken:String = ""
var _idRG:String = ""
let session = SessionManager.default
let function:Functions = Functions()
class ViewController: UIViewController {
    
    @IBOutlet weak var password: CustomTextFieldConnexion!
    @IBOutlet weak var username: CustomTextFieldConnexion!
    var alert:SCLAlertView = SCLAlertView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startNetworkReachabilityObserver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }

    
    func startNetworkReachabilityObserver() {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "https://realitygaming.fr")
        reachabilityManager?.listener = { status in
            
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                
            case .unknown :
                print("It is unknown whether the network is reachable")
                
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
    @IBAction func Connexion(_ sender: UIButton) {
        let password:String = self.password.text!
        let username:String = self.username.text!
        session.request(URL(string: "https://realitygaming.fr/login/login")!, method: .post, parameters: ["login":username,"password":password,"remember":"1","cookie_check":"1","_xfToken":"","redirect":"https://realitygaming.fr"], encoding: URLEncoding.default, headers: nil).responseString { (response) in
            let result = response.result.value!
            print(response.response?.statusCode)
            print(result)
            if result.contains("S'il vous plaît, essayez de nouveau.") || result.contains("demandé n'a pu être trouvé"){
               /* defaults.removeObject(forKey: "Username")
                defaults.removeObject(forKey: "Password")*/
              
              
                    self.alert.showError("Erreur connexion", subTitle: "Mot de passe ou pseudo incorrect", duration: 3)
                
            }else if result.contains("taigachat_message") || result.contains("messageShoutbox") {
                self.getTokenRG(reponce: result)
                self.getid(reponce: result)
                self.performSegue(withIdentifier: "Connexion", sender: self)
            }else if result.contains("Two-Step Verification Required") || result.contains("La vérification en deux étapes est requise"){
                self.alert = SCLAlertView()
                self.alert.addButton("Code Email", action: {
                    //Code par Email
                    self.alert = SCLAlertView()
                    let code = self.alert.addTextField("Code")
                    self.alert.addButton("Valider", action: {
                        
                        self.TwoStepRGEmail(code: "\(code.text)")
                    })
                    
                        self.alert.showSuccess("Verification en deux étapes", subTitle: "")
                        
                    
                })
                self.alert.addButton("Code Authenticator", action: {
                    //Code authenticator
                    self.alert = SCLAlertView()
                    let code = self.alert.addTextField("Code")
                    self.alert.addButton("Valider", action: {
                        
                        self.TwoStepRG(code: "\(code.text)")
                    })
                    
                        self.alert.showSuccess("Verification en deux étapes", subTitle: "")
                        
                    
                })
                
                let pseudo:String = function.GetElement(input: result.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n", with:"").replacingOccurrences(of: "\t", with: "") as NSString, paternn: "data-redirect=yes><dl class=ctrlUnit><dt>(.*?)textheading>").replacingOccurrences(of: "</dd></dl> <h3 class=textHeading>", with: "").replacingOccurrences(of: "data-redirect=yes><dl class=ctrlUnit><dt>Connexion en tant que:</dt><dd>", with: "").replacingOccurrences(of: "<h3 class=textHeading>", with: "") as String
                print(pseudo)
                self.alert.showNotice("Verification", subTitle: "Comment recevez vous le code pour le compte \(pseudo) ?")
                
            }else {
               /* defaults.removeObject(forKey: "Username")
                defaults.removeObject(forKey: "Password")*/
               

                    self.alert.showError("Erreur Connexion", subTitle: "Veuillez reassayer ultérieurement. Si l'erreur persiste veuillez contacter un membre du staff", duration: 3)
                
              
            }
        }

    }
    func TwoStepRG(code:String){
        let parametre:Parameters = ["code":code,"trust":"1","provider":"totp","_xfConfirm":"1","_xfToken":"","remember":"1"]
        self.alert = SCLAlertView()
        let url:URL = URL(string: "https://realitygaming.fr/login/two-step")!
        session.request(url, method: .post, parameters: parametre).responseString { (reponce) in
            
            let reponcef:String = reponce.result.value!
            
            if reponcef.contains("taigachat_message") || reponcef.contains("messageShoutbox"){
                
                self.getTokenRG(reponce: reponcef)
                self.getid(reponce: reponcef)
                self.performSegue(withIdentifier: "Connexion", sender: self)
            }else {
                self.alert.dismiss(animated: true, completion: nil)

                self.alert.showError("Erreur Two-Step", subTitle: "Code invalide !", duration: 3)
                
            }
        }
    }
    func TwoStepRGEmail(code:String){
        let parametre:Parameters = ["code":code,"trust":"1","provider":"email","_xfConfirm":"1","_xfToken":"","remember":"1"]
        self.alert = SCLAlertView()
        let url:URL = URL(string: "https://realitygaming.fr/login/two-step")!
        session.request(url, method: .post, parameters: parametre).responseString { (reponce) in
            
            let reponcef:String = reponce.result.value!
            
            if reponcef.contains("taigachat_message") || reponcef.contains("messageShoutbox"){
                
                self.getTokenRG(reponce: reponcef)
                self.getid(reponce: reponcef)
                self.performSegue(withIdentifier: "Connexion", sender: self)
            }else {
                self.alert.dismiss(animated: true, completion: nil)
         
                self.alert.showError("Erreur Two-Step", subTitle: "Code invalide !", duration: 3)
                
            }
        }
    }
    func getTokenRG(reponce:String){
        _xfToken = function.GetElement(input: reponce.replacingOccurrences(of: "\"", with: "") as NSString, paternn: "type=hidden name=_xfToken value=(.*?)/").replacingOccurrences(of: "type=hidden name=_xfToken value=", with: "").replacingOccurrences(of: "/", with: "") as String
        print(_xfToken)
    }
    func getid(reponce:String){
        _idRG = function.GetElement(input: reponce.replacingOccurrences(of: "\"", with: "") as NSString, paternn: "(.*?),").replacingOccurrences(of: "user_id: ", with: "").replacingOccurrences(of: ",", with: "")
        
    }


}

