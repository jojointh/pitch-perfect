//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Surasak Adulprasertsuk on 6/1/15.
//  Copyright (c) 2015 Surasak Adulprasertsuk. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!

    init(recordedUrl: NSURL, recordedTitle: String) {
        filePathUrl = recordedUrl
        title = recordedTitle
    }
    
}