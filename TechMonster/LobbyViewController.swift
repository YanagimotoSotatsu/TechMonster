//
//  LobbyViewController.swift
//  TechMonster
//
//  Created by 柳本宗達 on 2017/04/19.
//  Copyright © 2017年 柳本宗達. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    var maxStamina: Float = 100
    var stamina: Float = 100
    var player: Player = Player()
    var staminaTimer: Timer!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = String(format: "Lv. %d", player.level)
        
        stamina = maxStamina
        staminaBar.progress = stamina / maxStamina
        staminaTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cureStamina), userInfo: nil, repeats: true)

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.playBGM(fileName: "lobby")

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        TechDraUtil.stopBGM()
        
        print(stamina)
    }
    
    func cureStamina(){
        if stamina < maxStamina{
            stamina = min(stamina + 1, maxStamina)
            staminaBar.progress = stamina / maxStamina
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func startBattle(){
        if stamina >= 20{
            stamina = stamina - 20
            staminaBar.progress = stamina / maxStamina
            performSegue(withIdentifier: "startBattle", sender: nil)
        }else{
            let alert = UIAlertController(title: "スタミナ不足", message: "スタミナが２０以上必要です", preferredStyle:  .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        performSegue(withIdentifier: "startBattle", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "startBattle"{
            let battleVC = segue.destination as! BattleViewController
            player.currentHP = player.maxHP
            battleVC.player = player
    }
    
   }
}
