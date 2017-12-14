//
//  PrototypeLLViewDatasource.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 14.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import Foundation
import CoreLL

protocol PrototypeLLViewDatasource: class {
    
    func prototypeLLView(drawIn view: PrototypeLLView) -> CoreLinkedList<VisualLLNode>
    
}
