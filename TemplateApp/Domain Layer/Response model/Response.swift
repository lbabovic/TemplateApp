//
//  Response.swift
//  TemplateApp
//
//  Created by Luka Babovic on 28/02/2020.
//  Copyright © 2020 lbabovic. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case error(Error)
}
