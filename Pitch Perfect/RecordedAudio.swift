//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Mark Boyle on 2015-03-12.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathURL: NSURL
    var title: String
    
    init(title: String, filePathURL: NSURL){
        self.title = title
        self.filePathURL = filePathURL
    }
}