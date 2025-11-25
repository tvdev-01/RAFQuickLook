//
//  PreviewProvider.swift
//  RAFPreviewExtension
//
//  Created by Michael Costello on 25/11/2025.
//

import Quartz

class PreviewProvider: QLPreviewProvider, QLPreviewingController {
    
    func providePreview(for request: QLFilePreviewRequest) async throws -> QLPreviewReply {
                
        let rafUrl = request.fileURL
        
        // Extract the JPEG data

        guard let jpegData = extractJpegFromRaf(fileURL: rafUrl) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        // Create an NSImage container to read the size dimensions.

        let imageSize = NSImage(data: jpegData)?.size ?? CGSize(width: 800, height: 600)
        
        // Create the Reply

        return QLPreviewReply(dataOfContentType: .jpeg, contentSize: imageSize) { reply in
            return jpegData
        }

    }
    
}
