import math
if __name__ == '__main__':
    R = 6
    r = 1
    a = 8
    t = 0.00
    with open('./points_new.txt', 'w+') as f:
        f.write("[\n")
        while t < (20 * math.pi):
            x = (R + r) * math.cos((r / R) * t) - a * math.cos((1 + r / R) * t)
            y = (R + r) * math.sin((r / R) * t) - a * math.sin((1 + r / R) * t)
            result = "{\n\"loc\": [" + str((-118.2854378155344 + 0.0001 * y)) + "," + str((34.02059441981465 + 0.0001 * x)) + "]\n},\n"
            f.write(result)
            t += 0.1
        f.write("]")