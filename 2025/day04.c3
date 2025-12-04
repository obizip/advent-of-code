import std::io, std::collections, std::math, std::sort;

const INPUT_PATH = "input/input04.txt";
const LENGTH = 140;
// const INPUT_PATH = "input/input04-test.txt";
// const LENGTH = 10;

fn usz count_around(char[LENGTH][LENGTH] table, int x, int y)
{
	usz count = 0;
	for (int i = -1; i < 2; i++)
	{
		for (int j = -1; j < 2; j++)
		{
			if (i == 0 && j == 0) continue;
			if (0 <= x + i && x + i < LENGTH && 0 <= y + j && y + j < LENGTH)
			{
				if (table[y+j][x+i] == '@') count += 1;
			}

		}
	}
	return count;
}

fn long? solve1(char[LENGTH][LENGTH] table)
{
	long ans = 0;
	for (int x = 0; x < LENGTH; x++)
	{
		for (int y = 0; y < LENGTH; y++)
		{
			if (table[y][x] != '@') continue;
			usz count = count_around(table, x, y);
			if (count < 4) ans += 1;
		}
	}
	return ans;
}

fn long? solve2(char[LENGTH][LENGTH] table)
{
	long ans = 0;
	bool replaced = true;
	while (replaced)
	{
		replaced = false;
		for (int x = 0; x < LENGTH; x++)
		{
			for (int y = 0; y < LENGTH; y++)
			{
				if (table[y][x] != '@') continue;
				usz count = count_around(table, x, y);
				if (count < 4) {
					ans += 1;
					table[y][x] = '.';
					replaced = true;
				}
			}
		}
	}
	return ans;
}

fn void main()
{
	@pool()
	{
		File f = file::open(INPUT_PATH, "rb")!!;
		defer (void)f.close();

		List{String} lines;
		char[LENGTH][LENGTH] table;
		usz curr = 0;
		while (try line = io::treadline(&f)) {
			for (int i = 0; i < LENGTH; i++) {
				table[curr][i] = line[i];
			}
			curr++;
		}

		io::printfn("Q1: %d", solve1(table)!!);
		io::printfn("Q2: %d", solve2(table)!!);
	};
}
