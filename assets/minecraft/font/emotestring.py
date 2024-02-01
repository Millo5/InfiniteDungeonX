chars = "0123456789ABCDEF"
i = 0
for a in range(8):
    for b in range(16):
        if i == 8:
            print('",')
            i = 0
        if i == 0:
            print('"',end='')
        print('\\uEE%s%s'%(chars[a],chars[b]),end='')
        i += 1
print('"')