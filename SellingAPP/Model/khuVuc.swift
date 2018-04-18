//
//  khuVuc.swift
//  SellingAPP
//
//  Created by Bùi Văn Thương on 4/15/18.
//  Copyright © 2018 Bùi Văn Thương. All rights reserved.
//

import Foundation
class khuVuc: NSObject {
    var id_KV: String?
    var ten_KV: String?

    init?(KVjson:[String:Any]) {
        guard  let idKV = KVjson["ID_KV"] as? String else {return nil}
        guard let tenKV = KVjson["TEN_KV"] as? String else {return nil}
       
        self.id_KV = idKV
        self.ten_KV = tenKV
    }
    }
