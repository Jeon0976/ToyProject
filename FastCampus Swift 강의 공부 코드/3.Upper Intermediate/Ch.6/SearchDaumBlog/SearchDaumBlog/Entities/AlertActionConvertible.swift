//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 전성훈 on 2022/10/28.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style : UIAlertAction.Style { get }
}
