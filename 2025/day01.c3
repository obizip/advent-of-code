import std::io, std::io::file, std::collections::list;

fn long? solve1(List{String} lines)
{
	long n_zeros = 0;
	long max = 99;
	long divisor = max + 1;

	long curr = 50;
	foreach (line: lines)
	{
		char direction = line[0];
		long n_rots = (long)line[1..].to_int()!;

		switch(direction)
		{
			case 'R':
				curr += n_rots % divisor;
			case 'L':
				curr -= n_rots % divisor;
				if (curr < 0) curr += max + 1;

		}
		curr %= divisor;
		if (curr == 0) n_zeros++;
	}

	return n_zeros;
}

fn long? solve2(List{String} lines)
{
	long n_zeros = 0;
	long max = 99;
	long divisor = max + 1;

	long curr = 50;
	foreach (line: lines)
	{
		char direction = line[0];
		long n_rots = (long)line[1..].to_int()!;

		long rem = n_rots % divisor;
		long div = n_rots / divisor;
		if (div > 0) n_zeros += div;

		switch(direction)
		{
			case 'R':
				curr += rem;
				if (curr > max)
				{
					curr %= divisor;
					n_zeros++;
				}
			case 'L':
				long prev = curr;
				curr -= rem;
				// 0 -> 99 : one click makes it points at 99.
				if (curr < 1 && prev != 0) n_zeros++;

				if (curr < 0) curr += max + 1;
		}
	}

	return n_zeros;
}

fn void main()
{
	@pool()
	{
		File f = file::open("input/input01.txt", "rb")!!;
		// File f = file::open("input/input01-test.txt", "rb")!!;
		defer (void)f.close();

		List{String} lines;
		while (try line = io::treadline(&f)) lines.push(line);

		io::printfn("Q1: %d", solve1(lines)!!);
		io::printfn("Q2: %d", solve2(lines)!!);
	};
}
