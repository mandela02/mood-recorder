//
//  Clone.swift
//  Clone
//
//  Created by TriBQ on 8/24/21.
//

import Foundation

protocol Clone {
      associatedtype T
      func clone() -> T
}
