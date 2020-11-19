//
//  Protocols.swift
//  FilaMed
//
//  Created by Danilo Araújo on 30/06/20.
//  Copyright © 2020 FilaMed. All rights reserved.
//

import UIKit

protocol CodeView {
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
}


