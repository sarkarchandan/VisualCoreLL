//
//  MainViewController.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 10.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit
import CoreLL

class MainViewController: UIViewController,PrototypeLLViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        prepareListForDisplay()
        setupDrawableView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        detectDeviceOrientation(size)
    }
    
    private func setupNavigationController() {
        navigationItem.title = "Vulcan"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    private func setupDrawableView() {
        let prototypeLLView = Bundle.visualCoreBundle.loadNibNamed(PrototypeLLView.nibName, owner: nibName, options: nil)!.first as! PrototypeLLView
        prototypeLLView.translatesAutoresizingMaskIntoConstraints = false
        self.prototypeLLView = prototypeLLView
        view.addSubview(prototypeLLView)
        
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            prototypeLLView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            prototypeLLView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            prototypeLLView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            prototypeLLView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            prototypeLLView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            prototypeLLView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            prototypeLLView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            prototypeLLView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        prototypeLLView.list = list
        detectDeviceOrientation(view.bounds.size)
        prototypeLLView.delegate = self
    }    
    
    private func prepareListForDisplay() {
        
        let drawableNode1 = Node(with: VisualLLNode(radius: 35.0, arcColor: .red))
        
        let drawableNode2 = Node(with: VisualLLNode(radius: 35.0, arcColor: .green))
        
        let drawableNode3 = Node(with: VisualLLNode(radius: 35.0, arcColor: .blue))
        
        let drawableNode4 = Node(with: VisualLLNode(radius: 35.0, arcColor: .magenta))
        
        let drawableNode5 = Node(with: VisualLLNode(radius: 35.0, arcColor: .cyan))
        
        let drawableNode6 = Node(with: VisualLLNode(radius: 35.0,arcColor: .darkGray))
        
        let list = CoreLinkedList(with: drawableNode1)
        
        list.append(drawableNode2)
        list.append(drawableNode3)
        list.append(drawableNode4)
        list.append(drawableNode5)
        list.append(drawableNode6)
        
        self.list = list
    }
    
    //MARK: Implementation - PrototypeLLViewDelegate
    func prototypeLLViewShouldReload(_ view: PrototypeLLView) {
        list.reversed()
        view.list = list
    }
    
    private func detectDeviceOrientation(_ size: CGSize) {
        if size.height > size.width {
            prototypeLLView.orientation = .portrait
        }else {
            prototypeLLView.orientation = .landscape
        }
    }
    
    private var prototypeLLView: PrototypeLLView!
    private var list: CoreLinkedList<VisualLLNode>!
}

