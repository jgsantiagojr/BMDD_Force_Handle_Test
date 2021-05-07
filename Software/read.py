import serial
import time
import re
import csv

print("start up")
csv_columns = ["RAccelY", "LAccelY", "RAccelX", "LAccelX","RSense1","LSense1","RSense2","LSense2","RSense3", "LSense3"]
arduino = serial.Serial(port="COM10", baudrate=115200, timeout=.1)
processed_data = []
row={}
lines = 0
misses = 0
looking = True

print("ready to read")
while looking:
    data = arduino.readline()[:-2]
    if data:
        print("reading")
        data = str(data)
        if lines == 11:
            print(row)
            processed_data.append(row)
            row = {}
            lines = 0
        lines += 1
        # if data[:1]=="b'":
        data = data[2:]
        words = data.split(":")
        value = float(re.sub("[^\d\.]", "", words[1]))
        if words[0] in csv_columns:
            row[words[0]] = value
        print("%s: %s"%(words[0], value))
    else:
        misses += 1
    if misses == 50:
        looking = False

for x in processed_data:
    print(x)

csv_file = input('Save the data as?')+".csv"

try:
    with open(csv_file, 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
        writer.writeheader()
        for data in processed_data:
            writer.writerow(data)
except IOError:
    print("I/O error")
