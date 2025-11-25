//
//  Common.swift
//  RAFQuickLook
//
//  Created by Michael Costello on 25/11/2025.
//

import Foundation

/// Extracts the embedded JPEG from a Fuji RAF file.
///
/// - Parameter fileURL: The URL of the RAF file on disk.
/// - Returns: The extracted JPEG data, or nil if extraction fails.
public func extractJpegFromRaf(fileURL: URL) -> Data? {
    
    // Open the file handle for reading
    // Ensure the file handle is closed when we are done

    guard let fileHandle = try? FileHandle(forReadingFrom: fileURL) else {
        return nil
    }
    defer {
        try? fileHandle.close()
    }
    
    // Define the specific offsets in the header
    
    let offsetLocation: UInt64 = 0x54
    let lengthLocation: UInt64 = 0x58
    
    // Read the JPEG Offset
    // RAF headers typically use Big Endian byte order for integers

    guard (try? fileHandle.seek(toOffset: offsetLocation)) != nil else {
        return nil
    }
    guard let offsetData = try? fileHandle.read(upToCount: 4), offsetData.count == 4 else {
        return nil
    }
    let jpegOffset = UInt64(offsetData.withUnsafeBytes { $0.load(as: UInt32.self).bigEndian })
    
    // Read the JPEG Length

    guard (try? fileHandle.seek(toOffset: lengthLocation)) != nil else {
        return nil
    }
    guard let lengthData = try? fileHandle.read(upToCount: 4), lengthData.count == 4 else {
        return nil
    }
    let jpegLength = Int(lengthData.withUnsafeBytes { $0.load(as: UInt32.self).bigEndian })
    
    // Validate offsets
    
    guard let fileSize = try? fileHandle.seekToEnd() else {
        return nil
    }
    if jpegOffset + UInt64(jpegLength) > fileSize {
        return nil
    }
    
    // Extract the JPEG Data
    
    guard (try? fileHandle.seek(toOffset: jpegOffset)) != nil else {
        return nil
    }
    guard let jpegData = try? fileHandle.read(upToCount: jpegLength) else {
        return nil
    }

    return jpegData
}
