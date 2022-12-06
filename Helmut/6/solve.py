t = open("input","r").read()
# t = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
for i in range(len(t)-14):
    if len(set(t[i:i+14]))==14:
        print(i+14)
        break
        
