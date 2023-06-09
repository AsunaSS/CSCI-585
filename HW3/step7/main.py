import math
if __name__ == '__main__':
    R = 6
    r = 1
    a = 8
    t = 0.00
    with open('./points.txt', 'w+') as f:
        while t < (20 * math.pi):
            x = (R + r) * math.cos((r / R) * t) - a * math.cos((1 + r / R) * t)
            y = (R + r) * math.sin((r / R) * t) - a * math.sin((1 + r / R) * t)
            result = str((-118.2854378155344 + 0.0001 * y)) + "," + str((34.02059441981465 + 0.0001 * x)) + ",0.\n"
            f.write(result)
            t += 0.01