import os
import sys

def main(mult=1, niters=10_000, fp='/tmp/test.txt'):
	msg = 'Hello, neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...\n'
	print(f"Writing {mult=} * {niters=} copies of message:\n{msg}")
	text = mult * msg
	with open(fp, 'a') as f:
		for _ in range(niters):
			f.write(text)

if __name__ == '__main__':
	main(*sys.argv[1:])
