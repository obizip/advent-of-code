import std::io, std::collections, std::math, std::sort;

const INPUT_PATH = "input/input05.txt";
// const INPUT_PATH = "input/input05-test.txt";
// too low: 22781530743468
//        : 22781530743468

struct Range {
	long start;
	long end;
}

fn long? solve1(List{Range} ranges, List{long} ids)
{
	long ans = 0;

	foreach (id : ids)
	{
		foreach (range : ranges)
		{
			if (range.start <= id && id <= range.end)
			{
				ans++;
				break;
			}
		}
	}

	return ans;
}

fn long? solve2(List{Range} ranges, List{long} ids)
{
	long ans = 0;
	quicksort(&ranges, fn int (Range a, Range b) => ((int)math::sign(a.start - b.start)));

	usz i_curr = 0;
	Range curr = ranges[i_curr];
	long start = curr.start;
	long end = curr.end;
	i_curr++;
	while (true)
	{
		if (i_curr >= ranges.len())
		{
			ans += end - start + 1;
			break;
		}
		curr = ranges[i_curr];
		if (curr.start > end) // s - e - c.s - c.e
		{
			ans += end - start + 1;

			start = curr.start;
			end = curr.end;
			i_curr++;
		}
		else if (curr.end <= end) // s - c.s - c.e - e
		{
			i_curr++;
		}
		else // s - c.s - e - c.e
		{
			end = curr.end;
			i_curr++;
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
		bool is_range = true;
		List{Range} ranges;
		List{long} ids;
		while (try line = io::treadline(&f))
		{
			String[] splits = line.tsplit("-");

			if (line == "")
			{
				is_range = false;
				continue;
			}

			if (is_range)
			{
				ranges.push({splits[0].to_long()!!, splits[1].to_long()!!});
			}
			else
			{
				ids.push(line.to_long()!!);
			}
		}

		// io::printfn("%s", ranges);
		// io::printfn("%s", ids);

		io::printfn("Q1: %d", solve1(ranges, ids)!!);
		io::printfn("Q2: %d", solve2(ranges, ids)!!);
	};
}
