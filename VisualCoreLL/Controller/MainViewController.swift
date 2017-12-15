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
    
    private func setupNavigationController() {
        navigationItem.title = "Vulcan"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    private func setupDrawableView() {
        let prototypeView = Bundle.visualCoreBundle.loadNibNamed(PrototypeLLView.nibName, owner: nibName, options: nil)!.first as! PrototypeLLView
        prototypeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(prototypeView)
        
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            prototypeView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            prototypeView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            prototypeView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            prototypeView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            prototypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            prototypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            prototypeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            prototypeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        prototypeView.list = list
        prototypeView.delegate = self
    }    
    //MARK: Implementation - PrototypeLLViewDatasource
    func prepareListForDisplay() {
        
        let drawableNode1 = Node(with: VisualLLNode(radius: 40.0, lineWidth: 3.0, arcColor: .red))
        
        let drawableNode2 = Node(with: VisualLLNode(radius: 40.0, lineWidth: 3.0, arcColor: .green))
        
        let drawableNode3 = Node(with: VisualLLNode(radius: 40.0, lineWidth: 3.0, arcColor: .blue))
        
        let drawableNode4 = Node(with: VisualLLNode(radius: 40.0, lineWidth: 3.0, arcColor: .magenta))
        
        let drawableNode5 = Node(with: VisualLLNode(radius: 40.0, lineWidth: 3.0, arcColor: .cyan))
        
        let drawableNode6 = Node(with: VisualLLNode(radius: 40.0, lineWidth: 3.0, arcColor: .darkGray))
        
        let list = CoreLinkedList(with: drawableNode1)
        list.append(drawableNode2)
        list.append(drawableNode3)
        list.append(drawableNode4)
        list.append(drawableNode5)
        list.append(drawableNode6)
        self.list = list
    }
    
    //MARK: Implementation - PrototypeLLViewDelegate
    func prototypeLLViewDrawableOrderDidChange(_ view: PrototypeLLView) {
        list.reversed()
        view.list = list
    }
    
    private var list: CoreLinkedList<VisualLLNode>!
}

