import std::io, std::collections, std::math, std::sort;

// const INPUT_PATH = "input/input06-test.txt";
// const LENGTH = 10;
const INPUT_PATH = "input/input06.txt";
const LENGTH = 130;

alias Pos = Pair{int, int};

fn long? solve1(char[LENGTH][LENGTH] table, Pos guard)
{
	long ans = 0;
	String direction = "up";
	while OUTER: (true)
	{
		// io::printfn("%s %s", guard, direction);
		int x, y;
		guard.unpack(&x, &y);
		table[y][x] = 'X';
		switch (direction)
		{
			case "up":
				if (y - 1 < 0) break OUTER;
				if (table[y-1][x] == '#') 
				{
					direction = "right";
					continue OUTER;
				}
				guard = {x, y - 1};
			case "right":
				if (x + 1 >= LENGTH) break OUTER;
				if (table[y][x+1] == '#') 
				{
					direction = "down";
					continue OUTER;
				}
				guard = {x + 1, y};
			case "down":
				if (y + 1 >= LENGTH) break OUTER;
				if (table[y+1][x] == '#') 
				{
					direction = "left";
					continue OUTER;
				}
				guard = {x, y+1};
			case "left":
				if (x-1 < 0) break OUTER;
				if (table[y][x-1] == '#') 
				{
					direction = "up";
					continue OUTER;
				}
				guard = {x-1, y};
		}
		// io::printfn("!!!%s %s", guard, direction);
		// break OUTER;
	}
	for (int i = 0; i < LENGTH; i++) {
		for (int j = 0; j < LENGTH; j++) {
			if (table[i][j] == 'X') ans +=1;
		}
	}
	return ans;
}

// when same pos and direction appears then infinite loop.
fn long? solve2(char[LENGTH][LENGTH] table, Pos guard)
{
	long ans = 0;
	Pos start_pos = guard;
	String start_direction = "up";
	char [LENGTH][LENGTH] start_table = table;
	for (int row = 0; row < LENGTH; row++)
	{
		for (int col = 0; col < LENGTH; col++)
		{
			// io::printfn("%s %s", row, col);
			String direction = start_direction;
			guard = start_pos;
			table = start_table;

			if (table[row][col] == '#' || table[row][col] == '^') continue;
			table[row][col] = '#';

			while OUTER: (true)
			{
				int x, y;
				guard.unpack(&x, &y);
				// if (row == 5 && col == 110) io::printfn("%c (%s, %s)", table[y][x], x, y);

				switch (direction)
				{
					case "up":
						if (table[y][x] == 'u') 
						{
							ans += 1;
							break OUTER;
						}
						if (table[y][x] == '.') table[y][x] = 'u';
						if (y - 1 < 0) break OUTER;
						if (table[y-1][x] == '#') 
						{
							direction = "right";
							continue OUTER;
						}
						guard = {x, y - 1};
					case "right":
						if (table[y][x] == 'r') 
						{
							ans += 1;
							break OUTER;
						}
						if (table[y][x] == '.') table[y][x] = 'r';
						if (x + 1 >= LENGTH) break OUTER;
						if (table[y][x+1] == '#') 
						{
							direction = "down";
							continue OUTER;
						}
						guard = {x + 1, y};
					case "down":
						if (table[y][x] == 'd') 
						{
							ans += 1;
							break OUTER;
						}
						if (table[y][x] == '.') table[y][x] = 'd';
						if (y + 1 >= LENGTH) break OUTER;
						if (table[y+1][x] == '#') 
						{
							direction = "left";
							continue OUTER;
						}
						guard = {x, y+1};
					case "left":
						if (table[y][x] == 'l') 
						{
							ans += 1;
							break OUTER;
						}
						if (table[y][x] == '.') table[y][x] = 'l';
						if (x-1 < 0) break OUTER;
						if (table[y][x-1] == '#') 
						{
							direction = "up";
							continue OUTER;
						}
						guard = {x-1, y};
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
		// File f = file::open("input/input06.txt", "rb")!!;
		defer (void)f.close();

		char[LENGTH][LENGTH] table;
		Pos guard;
		int index = 0;
		while (try line = io::treadline(&f)) {
			io::printfn("%s", line[0..9]);
			for (int i = 0; i < line.len; i++)
			{
				if (line[i] == '^') guard = {i, index};
			}
			table[index] = line[0..LENGTH-1];
			index++;
		}
		io::printfn("%s", guard);

		io::printfn("Q1: %d", solve1(table, guard)!!);
		io::printfn("Q2: %d", solve2(table, guard)!!);
	};
}
