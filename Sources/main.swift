import SwiftIO
import MadBoard

var connected = false

var tempC: Float = .nan
var humidity: Float = .nan
var accel: (x: Float, y: Float, z: Float) = (x:.nan, y: .nan, z:.nan)
var ppm: Int16 = -1

let co2Mutex: Mutex = Mutex()
let espMutex: Mutex = Mutex()
let i2cMutex: Mutex = Mutex()

sleep(ms: 1000)

print("main thread - Spawning ESP WIFI thread.")
createThread(name: "esp",
             priority: 2,
             stackSize: 1024 * 64,
             espThread)
sleep(ms: 10)

print("main thread - Spawning CO2 sensor thread.")
createThread(name: "co2_uart",
             priority: 3,
             stackSize: 1024 * 64,
             co2Thread)
sleep(ms: 10)
print("main thread - spawned.")

print("main thread - spawning I2CThread...")
createThread(name: "i2c",
             priority: 4,
             stackSize: 1024 * 64,
             I2CThread)
sleep(ms: 10)
print("main thread - spawned.")

// loop
while true {
    print("temp \(tempC)")
    print("RH \(humidity)")
    print("CO2ppm \(ppm)")
    sleep(ms: 10_000)
}