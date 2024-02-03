chars = "0123456789ABCDEF"
i = 0
width = 5
height = 2

for a in range(width):
    for b in range(height):
        if i == width:
            print('",')
            i = 0
        if i == 0:
            print('"',end='')
        print('\\uE4%s%s'%(chars[a],chars[b]),end='')
        i += 1
print('"')