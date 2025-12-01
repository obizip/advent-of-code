import std::io, std::io::file, std::collections::list, std::sort, std::math;

fn long? solve1(List{String} lines)
{
	long ans = 0;
	usz n = lines.len();
	long[1024] lefts;
	long[1024] rights;
	foreach (i, line: lines)
	{
		String[] nums = line.tsplit("   ", max: 2);
		lefts[i] = (long)nums[0].to_int()!;
		rights[i] = (long)nums[1].to_int()!;
	}
	sort::quicksort(lefts[:n]);
	sort::quicksort(rights[:n]);

	for (int i = 0; i < n; i++)
	{
		long l = lefts[i];
		long r = rights[i];
		ans += math::abs(l-r);
	}
		
	return ans;
}

fn long? solve2(List{String} lines)
{
	long ans = 0;
	usz n = lines.len();
	long[1024] lefts;
	long[1024] rights;
	foreach (i, line: lines)
	{
		String[] nums = line.tsplit("   ", max: 2);
		lefts[i] = (long)nums[0].to_int()!;
		rights[i] = (long)nums[1].to_int()!;
	}
	for (int i = 0; i < n; i++)
	{
		long l = lefts[i];
		long counts = 0;
		for (int j = 0; j < n; j++)
		{
			if (l == rights[j]) counts++;
		}
		ans += l * counts;
	}
		
	return ans;
}

fn void main()
{
	@pool()
	{
		// File f = file::open("input/input01-test.txt", "rb")!!;
		File f = file::open("input/input01.txt", "rb")!!;
		defer (void)f.close();

		List{String} lines;
		while (try line = io::treadline(&f)) lines.push(line);

		io::printfn("Q1: %d", solve1(lines)!!);
		io::printfn("Q2: %d", solve2(lines)!!);
	};
}
