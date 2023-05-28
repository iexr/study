Import.module Data.Angle

a :: Float
a = 25.4

b :: Float
b = 52.3

c :: Float
c = 59.3

d :: Float
d = 56.4

theta2 :: Int
theta2 = 30

ax = map a * cosradians theta2
ay = map a * sin radians theta2

s = (a ** 2 - b ** 2 + c ** 2 - d ** 2) / (2 * (ax - d))
q = (2 * (ay * (d - s))) / (ax - d)
p = ((ay ** 2) / (ax - d) ** 2 ) + 1
r = ((d - s) ** 2) - (c ** 2)

by1 = (-q + Math.sqrt(q ** 2 - (4 * (p * r)))) / (2 * p)
by2 = (-q - Math.sqrt(q ** 2 - (4 * (p * r)))) / (2 * p)
bx1 = (s - ((2 * ay * by1)) / (2 * (ax - d)))
bx2 = (s - ((2 * ay * by2) / (2 * (ax - d))))
