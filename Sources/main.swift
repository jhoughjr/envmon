import SwiftIO
import MadBoard

sleep(ms: 1000)
print("main thread - Spawning CO2 sensor thread.")
createThread(name: "co2_uart",
             priority: 3,
             stackSize: 1024 * 64,
             co2Thread)
sleep(ms: 10)
print("main thread - spawned.")


print("main thread - Spawning ESP WIFI thread.")
createThread(name: "esp",
             priority: 2,
             stackSize: 1024 * 64,
             espThread)
sleep(ms: 10)
print("main thread - spawned.")

print("main thread - spawning I2CThread...")
createThread(name: "i2c",
             priority: 4,
             stackSize: 1024 * 64,
             I2CThread)
sleep(ms: 10)
print("main thread - spawned.")

while true {
    print("main thread - snoozing for 10 s zzzzz")
    sleep(ms: 10_000)
}