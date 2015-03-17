//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Ankit Garg on 17/03/15.
//  Copyright (c) 2015 Ankit Garg. All rights reserved.
//

import Foundation



class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
    init(pathURL pathUrl: NSURL!, fileTitle title: String!) {
        //super.init(pathUrl, fileTitle)
        self.filePathUrl = pathUrl
        self.title = title
        
    }
}