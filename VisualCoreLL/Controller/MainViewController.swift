//
//  MainViewController.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 10.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import UIKit
import CoreLL

class MainViewController: UIViewController, PrototypeLLViewDatasource,PrototypeLLViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
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
        prototypeView.backgroundColor = .lightGray
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
        
        prototypeView.datasource = self
        prototypeView.delegate = self
    }
    
    //MARK: Implementation - PrototypeLLViewDatasource
    func prototypeLLView(drawIn view: PrototypeLLView) -> CoreLinkedList<VisualLLNode> {
        let center = CGPoint(x: view.bounds.midX, y: 30.0)
        let drawableNode = Node(with: VisualLLNode(center:  center, radius: 20.0, lineWidth: 2.0, arcColor: .red))
        let list = CoreLinkedList(with: drawableNode)
        return list
    }
    
    //MARK: Implementation - PrototypeLLViewDelegate
    func prototypeLLViewDrwableOrderDidChange(_ view: PrototypeLLView) {
        fatalError("prototypeLLViewDrwableOrderDidChange(_:) is not implemented")
    }
}

