import Foundation
import WWExtensions

public extension String {
    var reversedData: Data? {
        self.ww.hexData.map { Data($0.reversed()) }
    }
}
