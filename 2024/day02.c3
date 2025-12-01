import std::io, std::io::file, std::collections::list, std::math;

fn long? solve1(List{String} lines)
{
	long ans = 0;
	foreach (line : lines)
	{
		long[256] nums;
		String[] splits = line.tsplit(" ");
		usz n_levels = splits.len;
		foreach (i, raw : splits) nums[i] = raw.to_long()!;

		bool is_increasing = true;
		bool is_decreasing = true;
		bool is_valid = true;
		for (int i = 1; i < n_levels; i++)
		{
			is_increasing &= nums[i] > nums[i-1];
			is_decreasing &= nums[i] < nums[i-1];
			long gap = math::abs(nums[i] - nums[i-1]);
			bool is_valid_gap = 1 <= gap && gap <=3;
			is_valid &= (is_increasing || is_decreasing) && is_valid_gap;
		}
		if (is_valid) ans += 1;
	}
	return ans;
}

fn long? solve2(List{String} lines)
{
	long ans = 0;
	foreach (line : lines)
	{
		long[256] nums;
		String[] splits = line.tsplit(" ");
		usz n_levels = splits.len;
		foreach (i, raw : splits) nums[i] = raw.to_long()!;
		for (int i_skip = 0; i_skip < n_levels; i_skip++)
		{
			long[256] skipped;
			usz curr = 0;
			for (int i = 0; i < n_levels; i++)
			{
				if (i_skip == i) continue;
				skipped[curr] = nums[i];
				curr++;
			}

			bool is_increasing = true;
			bool is_decreasing = true;
			bool is_valid = true;
			for (int i = 1; i < n_levels - 1; i++)
			{
				is_increasing &= skipped[i] > skipped[i-1];
				is_decreasing &= skipped[i] < skipped[i-1];
				long gap = math::abs(skipped[i] - skipped[i-1]);
				bool is_valid_gap = 1 <= gap && gap <=3;
				is_valid &= (is_increasing || is_decreasing) && is_valid_gap;
			}
			if (is_valid)
			{
				ans += 1;
				break;
			}
		}
	}
	return ans;
}

fn void main()
{
	@pool()
	{
		// File f = file::open("input/input02-test.txt", "rb")!!;
		File f = file::open("input/input02.txt", "rb")!!;
		defer (void)f.close();

		List{String} lines;
		while (try line = io::treadline(&f)) lines.push(line);

		io::printfn("Q1: %d", solve1(lines)!!);
		io::printfn("Q2: %d", solve2(lines)!!);
	};
}
