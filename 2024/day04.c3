import std::io, std::io::file, std::collections::list;

fn char[4] vertical(char[LENGTH][LENGTH] table, int x, int y)
{
	char[4] ret;
	ret[0] = table[y][x];
	ret[1] = table[y + 1][x];
	ret[2] = table[y + 2][x];
	ret[3] = table[y + 3][x];
	return ret;
}

fn char[4] horizontal(char[LENGTH][LENGTH] table, int x, int y)
{
	return table[y][x:4];
}

fn char[4] diag_right(char[LENGTH][LENGTH] table, int x, int y)
{
	char[4] ret;
	ret[0] = table[y][x];
	ret[1] = table[y + 1][x + 1];
	ret[2] = table[y + 2][x + 2];
	ret[3] = table[y + 3][x + 3];
	return ret;
}

fn char[4] diag_left(char[LENGTH][LENGTH] table, int x, int y)
{
	char[4] ret;
	ret[0] = table[y][x];
	ret[1] = table[y + 1][x - 1];
	ret[2] = table[y + 2][x - 2];
	ret[3] = table[y + 3][x - 3];
	return ret;
}

fn long? solve1(char[LENGTH][LENGTH] table)
{
	long ans = 0;
	for (int y = 0; y < LENGTH; y++) {
		for (int x = 0; x < LENGTH; x++) {
			if (x + 3 < LENGTH &&
				(table[y][x:4] == "XMAS" || table[y][x:4] == "SAMX"))
			{
				ans += 1;
			}
			if (y + 3 < LENGTH &&
				(vertical(table, x, y)[..] == "XMAS" || vertical(table, x, y)[..] == "SAMX"))
			{
				ans += 1;
			}
			if ((x + 3 < LENGTH && y + 3 < LENGTH) &&
				(diag_right(table, x, y)[..] == "XMAS" || diag_right(table, x, y)[..] == "SAMX"))
			{
				 ans += 1;
			}
			if ((x - 3 >= 0 && y + 3 < LENGTH) &&
				(diag_left(table, x, y)[..] == "XMAS" || diag_left(table, x, y)[..] == "SAMX"))
			{
				 ans += 1;
			}
		}
	}
	return ans;
}

fn long? solve2(char[LENGTH][LENGTH] table)
{
	long ans = 0;
	for (int y = 0; y < LENGTH; y++) {
		for (int x = 0; x < LENGTH; x++) {
			if (x + 2 < LENGTH && y + 2 < LENGTH)
			{
				 char[3] right;
				 char[3] left;
				 right[0] = table[y][x];
				 right[1] = table[y + 1][x + 1];
				 right[2] = table[y + 2][x + 2];
				 left[0] = table[y][x + 2];
				 left[1] = table[y + 1][x + 1];
				 left[2] = table[y + 2][x];
				 if ((right[..] == "MAS" || right[..] == "SAM")
				     && (left[..] == "MAS" || left[..] == "SAM")) ans += 1;
			}
		}
	}
	return ans;
}

// const LENGTH = 10; // test
const LENGTH = 140;

fn void main()
{
	@pool()
	{
		// File f = file::open("input/input04-test.txt", "rb")!!;
		File f = file::open("input/input04.txt", "rb")!!;
		defer (void)f.close();

		// List{String} lines;
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
