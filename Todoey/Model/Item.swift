//
//  Item.swift
//  Todoey
//
//  Created by Moh on 21/05/2023.
//  Copyright © 2023 Game X. All rights reserved.
//

import Foundation
 
//. STEP 6
//. create a skeletone model for the  project


class Item: Codable{
    var title: String = ""
    var done: Bool = false
}

//. STEP 17
//. add encodable to the Item class, so that the code can use encode

//. STEP 27
//. add a decodable method to the Item class, combine both encodable, and decodable to form codable
