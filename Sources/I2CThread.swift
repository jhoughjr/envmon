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
    i2cMutex.lock()
    tempC = humiture.readCelsius()
    humidity = humiture.readHumidity()
    accel = accelerometer.readXYZ()
    i2cMutex.unlock()
    
    sleep(ms: 1000)
}
    
}