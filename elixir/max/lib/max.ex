defmodule Max do

	def result do
		a = 25.4
		b = 52.3
		c = 59.3
		d = 56.4

		theta2 = 30

		ax = a * (Math.cos(Math.deg2rad(theta2)))
		ay = a * (Math.sin(Math.deg2rad(theta2)))

		s = (a ** 2 - b ** 2 + c ** 2 - d ** 2) / (2 * (ax - d))
		q = (2 * (ay * (d - s))) / (ax - d)
		p = ((ay ** 2) / (ax - d) ** 2 ) + 1
		r = ((d - s) ** 2) - (c ** 2)

		by1 = (-q + Math.sqrt(q ** 2 - (4 * (p * r)))) / (2 * p)
		by2 = (-q - Math.sqrt(q ** 2 - (4 * (p * r)))) / (2 * p)
		bx1 = (s - ((2 * ay * by1)) / (2 * (ax - d)))
		bx2 = (s - ((2 * ay * by2) / (2 * (ax - d))))

		theta3pos = Math.atan2((by1 - ay), (bx1 - ax)) # 61,290206781
		|> Math.rad2deg

		theta3neg = Math.atan2((by2 - ay), (bx2 - ax)) # 78.18784920716686
		|> Math.rad2deg

		theta4pos = Math.atan2(by1, (bx1 - d)) # -80.99856613294048
		|> Math.rad2deg

		theta4neg = Math.atan2(by2, (bx2 - d)) # 40.47487892266992
		|> Math.rad2deg

		"Theta 3 :: P = #{theta3pos}, N = #{theta3neg} e Theta 4 :: P = #{theta4pos}, N = #{theta4neg}"

		end

end
