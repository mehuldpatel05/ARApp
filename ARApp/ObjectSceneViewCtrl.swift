//
//  ObjectSceneViewCtrl.swift
//  ARApp
//
//  Created by FPrimeC on 2021-10-23.
//

import UIKit
import SceneKit

class ObjectSceneViewCtrl: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let scene = SCNScene(named: "converse_obj.obj")
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        cameraNode.position = SCNVector3(0, 10, 35)
        scene?.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 10, 35)
        scene?.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        sceneView.allowsCameraControl = true
        
        sceneView.backgroundColor = .white
        
        sceneView.cameraControlConfiguration.allowsTranslation = false
        
        sceneView.scene = scene
        
    }

}
