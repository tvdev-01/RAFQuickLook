//
//  ThumbnailProvider.swift
//  RAFThumbnailExtension
//
//  Created by Michael Costello on 25/11/2025.
//

import AppKit
import QuickLookThumbnailing

class ThumbnailProvider: QLThumbnailProvider {
    
    override func provideThumbnail(
        for request: QLFileThumbnailRequest,
        _ handler: @escaping (QLThumbnailReply?, Error?) -> Void
    ) {
        
        // Extract JPEG data from RAF and decode into CGImage

        guard
            let jpegData = extractJpegFromRaf(fileURL: request.fileURL),
            let source = CGImageSourceCreateWithData(jpegData as CFData, nil),
            let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil)
        else {
            handler(nil, nil)
            return
        }

        // Create temporary file

        let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("jpg")

        // Write JPEG to temp file

        let jpegUTI = UTType.jpeg.identifier as CFString
        if let destination = CGImageDestinationCreateWithURL(tmpURL as CFURL, jpegUTI, 1, nil) {
            CGImageDestinationAddImage(destination, cgImage, nil)
            CGImageDestinationFinalize(destination)
        } else {
            handler(nil, nil)
            return
        }

        // Return using macOS Quick Look thumbnail reply

        let reply = QLThumbnailReply(imageFileURL: tmpURL)
        handler(reply, nil)
        
    }

}
