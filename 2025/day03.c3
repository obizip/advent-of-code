import std::io, std::collections, std::math, std::sort;

const INPUT_PATH = "input/input03.txt";
// const INPUT_PATH = "input/input03-test.txt";
const ZERO = 48;

fn long? solve1(List{String} lines)
{
	long ans = 0;
	foreach (line : lines) {
		int max = -1;
		int i_max = -1;
		for (int i = line.len - 2; i >= 0; i--) {
			int curr = line[i] - ZERO;
			if (curr >= max)
			{
				max = curr;
				i_max = i;
			}
		}
		int max2 = -1;
		for (int j = i_max + 1; j < line.len; j++)
		{
			int curr = line[j] - ZERO;
			if (curr >= max2) 
			{
				max2 = curr;
			}
		}
		// io::printfn("%d %d %d", max * 10 + max2, max, max2);
		ans += (long)(max * 10 + max2);
	}
	return ans;
}

fn ulong? solve2(List{String} lines)
{
	ulong ans = 0;
	foreach (line : lines) {
		int i_max_prev = -1;
		for (int i_digit = 0; i_digit < 12; i_digit++)
		{
			int max = -1;
			int i_max = -1;
			for (int i = line.len - 12 + i_digit; i > i_max_prev; i--) {
				int curr = line[i] - ZERO;
				if (curr >= max)
				{
					max = curr;
					i_max = i;
				}
			}
			i_max_prev = i_max;
			ans += (ulong)max * (ulong)math::pow(10, 12-1-i_digit);
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
		while (try line = io::treadline(&f)) {
			lines.push(line);
		}

		io::printfn("Q1: %d", solve1(lines)!!);
		io::printfn("Q2: %d", solve2(lines)!!);
	};
}
