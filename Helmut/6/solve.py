t = open("input","r").read()
# t = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
for i in range(len(t)-4):
    if len(set(t[i:i+4]))==4:
        print(i+4)
        break
        
