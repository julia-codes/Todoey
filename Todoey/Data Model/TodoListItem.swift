//
//  TodoListItem.swift
//  Todoey
//
//  Created by Julia Layne on 3/13/18.
//  Copyright © 2018 Julia codes. All rights reserved.
//

import Foundation
class TodoListItem : Codable {
    var title :String = ""
    var done :Bool = false
    init(_ uiText : String){
        title = uiText
    }
    init(uiText : String, checkValue :Bool) {
        title = uiText
        done = checkValue
    }
}
