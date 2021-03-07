/**
File Name : GameViewController.swift
Author's name : Manoj Manikantan Muralidharan
Student ID : 301067347
Date : 7th Mar 2021
App Description : Adjust the game to work in Landscape direction from right to left
 */



import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{

    @IBOutlet weak var LivesLabel: UILabel!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
        }
        
        CollisionManager.gameViewController = self
        ScoreManager.Score = 0
        ScoreManager.Lives = 5
        updateLivesLabel()
        updateScoreLabel()
        
    }

    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func updateScoreLabel() -> Void
    {
        ScoreLabel.text  = "Score: \(ScoreManager.Score)"
    }
        
    func updateLivesLabel() -> Void
    {
        LivesLabel.text = "Lives: \(ScoreManager.Lives)"
    }
    
}
