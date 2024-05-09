import SwiftIO
import MadBoard
import ESP32ATClient

let esp_sleep:Int = 3_000

func espThread(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?, _ c: UnsafeMutableRawPointer?) -> () {
    while true {
    print(" esp_thread - sleeping for \(esp_sleep) ms...")
    sleep(ms: esp_sleep)
    print(" esp thread awake!")
    }
}