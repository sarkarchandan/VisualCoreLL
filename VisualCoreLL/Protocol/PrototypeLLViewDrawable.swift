//
//  PrototypeLLViewDrawable.swift
//  VisualCoreLL
//
//  Created by Chandan Sarkar on 15.12.17.
//  Copyright © 2017 Chandan Sarkar. All rights reserved.
//

import Foundation
import CoreLL

protocol  PrototypeLLViewDrawable: class {
    
    var list: CoreLinkedList<VisualLLNode>! { get set }
    
}
