import SwiftIO
import MadBoard
import SHT3x
import LIS3DH

func I2CThread(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?, _ c: UnsafeMutableRawPointer?) -> () {
    // Initialize the I2C interface and use it to initialize the sensor.
let i2c = I2C(Id.I2C0)
let humiture = SHT3x(i2c)
let accelerometer = LIS3DH(i2c)

while true {
    let temp = humiture.readCelsius()
    let humidity = humiture.readHumidity()
    print("I2C - Temperature: \(temp)C")
    print("I2C - Humidity: \(humidity)%")
    let accelerations = accelerometer.readXYZ()
    print("I2C - x: \(accelerations.x)g")
    print("I2C - y: \(accelerations.y)g")
    print("I2C - z: \(accelerations.z)g")
    print("\n")
    print("Sleeping for 1s...")
    sleep(ms: 1000)
}
    
}