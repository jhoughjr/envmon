import SwiftIO
import MadBoard
import ESP32ATClient

let esp_sleep:Int = 30_000
let url = "http://192.168.1.243:8080/envdata"

func espThread(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?, _ c: UnsafeMutableRawPointer?) -> () {

let rst = DigitalOut(Id.D24, value: true)
let uart = UART(Id.UART1, baudRate: 115200)
let esp = ESP32ATClient(uart: uart, rst: rst)

while !connected {
    do {
        // If reset failed, you might need to adjust the baudrate.
        try esp.reset()
        print("ESP32 status: \(esp.esp32Status)")

        // Only in 'Station' or 'Station+SoftAP' mode can a connection to an AP be established.
        var wifiMode = ESP32ATClient.WiFiMode.station
        _ = try esp.setWiFiMode(wifiMode)

        wifiMode = try esp.getWiFiMode()
        print("ESP32 WiFi mode: \(wifiMode)")

        // Fill the SSID and password below.
        try esp.joinAP(ssid: "TP-Link_3E64", password: "22426031", timeout: 30000)
        print("ESP32 WiFi status: \(esp.wifiStatus)")

        let ipInfo = try esp.getStationIP()
        print(ipInfo)
        espMutex.lock()
        connected = true
        espMutex.unlock()
    } 
    catch {
        print("Error: \(error)")
        espMutex.lock()
        connected = false
        espMutex.unlock()
    }
}

while connected {
    print("sending to \(url)")
espMutex.lock()
var t = tempC * 10
t.round(.toNearestOrAwayFromZero)
let value = t / 10.0
let d = 
"""
{"tempC":\(value),
 "hum" : \(Int(humidity)),
 "ppm" : \(ppm),
 "accel" : {"x" : \(accel.x), "y" : \(accel.y), "z" : \(accel.z)}
 }
"""
espMutex.unlock()
do {
    let s = try esp.httpPost(url: url, data: d, headers: ["Content-Type : application/json" ])
    print("response: \(s)")
}
catch {
    print("esp error: \(error)")
}
sleep(ms: esp_sleep)
}

}