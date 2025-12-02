import std::io, std::io::file, std::collections::list, std::collections::pair;

fn long? solve1(Ranges ranges)
{
	long ans = 0;
	foreach (range : ranges) {
		ulong begin, end;
		range.unpack(&begin, &end);
		for (ulong n = begin; n <= end; n++)
		{
			String s = string::tformat("%s", n);
			if (s.len % 2 == 1) continue;
			usz half = s.len/2;
			if(s[..half-1] == s[half..])
			{
				ans += n;
			}
		}
	}
	return ans;
}

fn long? solve2(Ranges ranges)
{
	long ans = 0;
	foreach (range : ranges) {
		ulong begin, end;
		range.unpack(&begin, &end);
		for (ulong n = begin; n <= end; n++)
		{
			String s = string::tformat("%s", n);
			usz half = s.len/2;
			for (usz step = 1; step <= half; step++)
			{
				if (s.len % step != 0) continue;
				bool is_valid = true;
				for (usz j = 0; j + 2*step-1 < s.len; j += step)
				{
					if(s[j:step] != s[j+step:step])
					{
						is_valid = false;
						break;
					}
				}
				if (is_valid)
				{
					ans += n;
					break;
				}
			}
		}
	}
	return ans;
}

alias Range = Pair{ulong, ulong};
alias Ranges = List{Range};

fn void main()
{
	@pool()
	{
		// File f = file::open("input/input02-test.txt", "rb")!!;
		File f = file::open("input/input02.txt", "rb")!!;
		defer (void)f.close();

		Ranges ranges;
		while (try line = io::treadline(&f)) 
		{
			String[] raw_ranges = line.tsplit(",");
			foreach (range : raw_ranges) 
			{
				String[] splits = range.tsplit("-");
				ulong begin = splits[0].to_ulong()!!;
				ulong end = splits[1].to_ulong()!!;
				ranges.push({begin, end});
			}
		}

		io::printfn("Q1: %d", solve1(ranges)!!);
		io::printfn("Q2: %d", solve2(ranges)!!);
	};
}
